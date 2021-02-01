class GameSerializer

  def initialize(game_obj)
    @game = game_obj
  end

  def index_to_serialized_json
    options = {
      only: [:id, :name]
    }
    @game.to_json(options)
  end

  def show_to_serialized_json
    options = {
      include: [:publishers, :developers, :genres],
      only: [:id, :name, :release_date, :url, :cover_url]
    }
    @game.to_json(options)
  end

  def publishers
    CompanySerializer.new(@game.publishers).to_serialized_json
  end
  
  def developers
    CompanySerializer.new(@game.developers).to_serialized_json
  end

  def genres
    GenreSerializer.new(@game.genres).to_serialized_json
  end

end