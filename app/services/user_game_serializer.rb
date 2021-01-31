class UserGameSerializer

  def initialize(user_game_obj)
    @user_game = user_game_obj
  end

  def index_to_serialized_json
    options = {
      include: {
        game: {
          only: [:name, :cover_url]
        }
      }
    }
    @user_game.to_json(options)
  end

  def show_to_serialized_json
    options = {
      include: {
        game: {
          only: [:id]
        },
        tasks: {
          only: [:id, :name]
        },
        loadouts: {
          only: [:id, :name]
        }
      }
    }
    @user_game.to_json(options)
  end

end