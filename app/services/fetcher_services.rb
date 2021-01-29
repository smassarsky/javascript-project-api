require 'net/https'
module FetcherServices

  class TokenFetcher
    include FetcherServices

    def self.current_token
      last_token = TwitchToken.last
      if last_token
        if last_token.created_at < Time.now - 1.hours
          revoke_token(last_token)
          last_token = get_token
        end
        last_token.token
      else
        get_token.token
      end
    end

    def self.get_token
      uri = URI("https://id.twitch.tv/oauth2/token")
      resp = Net::HTTP.post_form(uri, {'client_id': ENV['TWITCH_CLIENT_ID'], 
                                       'client_secret': ENV['TWITCH_CLIENT_SECRET'], 
                                       'grant_type': 'client_credentials'})
      TwitchToken.create(token: JSON.parse(resp.body)['access_token'])
    end

    def self.revoke_token(last_token)
      uri = URI("https://id.twitch.tv/oauth2/revoke")
      resp = Net::HTTP.post_form(uri, {'client_id': ENV['TWITCH_CLIENT_ID'],
                                       'token': last_token.token})
      TwitchToken.destroy_all
    end

  end

  class GamesFetcher

    def self.fetch_500_games(offset)
      http = FetcherServices.build_http
      req = FetcherServices.build_req(URI("https://api.igdb.com/v4/games"))
      req.body = "fields name, first_release_date, url, genres, involved_companies.company, cover.url\; limit 500\; where involved_companies != null & rating_count > 250\;"
      res = http.request(req)
      JSON.parse(res.body).each do |game_hash|
        create_game(game_hash)
      end
    end

    def self.create_game(game_hash)
      new_game = Game.find_or_create_by(api_id: game_hash['id']) do |t|
        t.name = game_hash['name']
        t.release_date = Time.at(game_hash['first_release_date']).to_datetime
        t.url = game_hash['url']
        t.cover_url = game_hash['cover']['url']
        t.genres = Genre.where(api_id: game_hash['genres'])
        game_hash['involved_companies'].each do |company|
          if !t.involved_companies.find_by(api_id: company['id'])
            new_involved = t.involved_companies.build(api_id: company['id'])
            new_involved.company = Company.find_or_create_by(api_id: company['company'])
          end
        end
      end
    end

    def self.fix_games
      Game.all.each do |game|
        game.cover_url = game.cover_url.gsub(/t_thumb/, "t_720p")
        game.save
      end
    end

  end

  class CompaniesFetcher

    def self.fetch_involved_companies_in_batches
      InvolvedCompany.in_batches(of: 100).each do |batch|
        sleep(4)
        batch.pluck(:api_id).to_s.gsub(/[\[\]]/, '')
        http = FetcherServices.build_http
        req = FetcherServices.build_req(URI("https://api.igdb.com/v4/involved_companies"))
        req.body = "fields developer, publisher, supporting\; where id = (#{batch.pluck(:api_id).to_s.gsub(/[\[\]]/, '')})\; limit 100\;"
        res = http.request(req)
        JSON.parse(res.body).each do |involved_company_hash|
          add_involved_company_details(involved_company_hash)
        end
      end
    end

    def self.add_involved_company_details(involved_company_hash)
      involved = InvolvedCompany.find_by(api_id: involved_company_hash['id'])
      involved.update(developer: involved_company_hash['developer'], 
                      publisher: involved_company_hash['publisher'], 
                      supporting: involved_company_hash['supporting'])
    end

    def self.fetch_companies_in_batches
      Company.in_batches(of: 100).each do |batch|
        sleep(4)
        http = FetcherServices.build_http
        req = FetcherServices.build_req(URI("https://api.igdb.com/v4/companies"))

        req.body = "fields name, url, start_date\; where id = (#{batch.pluck(:api_id).to_s.gsub(/[\[\]]/, '')})\; limit 100\;"
        res = http.request(req)
        JSON.parse(res.body).each do |involved_company_hash|
          add_company_details(involved_company_hash)
        end

      end
    end

    def self.add_company_details(company_hash)
      company = Company.find_by(api_id: company_hash['id'])
      company.name = company_hash['name']
      company.start_date = Time.at(company_hash['start_date']).to_datetime if company_hash['start_date']
      company.url = company_hash['url']
      company.save
    end

    # http = FetcherServices.build_http
    # req = FetcherServices.build_req(URI("https://api.igdb.com/v4/involved_companies"))
    # req.body = "fields developer, publisher, supporting, company.*\; where id = (#{})"

    
  end

  class GenresFetcher

    def self.fetch_genres
      http = FetcherServices.build_http
      req = FetcherServices.build_req(URI("https://api.igdb.com/v4/genres"))
      req.body = "fields name\; limit 500\;"
      res = http.request(req)
      JSON.parse(res.body).each do |genre_hash|
        create_genre(genre_hash)
      end
    end

    def self.create_genre(genre_hash)
      Genre.find_or_create_by(api_id: genre_hash['id']) do |t|
        t.name = genre_hash['name']
      end
    end

  end

  def self.build_req(uri)
    Net::HTTP::Post.new(uri, 
    {
      'Client-ID' => ENV['TWITCH_CLIENT_ID'],
      'Authorization' => "Bearer #{TokenFetcher.current_token}"
    })
  end

  def self.build_http
    http = Net::HTTP.new('api.igdb.com', 443)
    http.use_ssl = true
    http
  end

end
