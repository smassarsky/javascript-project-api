class UserGamesController < ApplicationController

  def index
    user_games = @current_user.user_games.all
    render json: UserGameSerializer.new(user_games).index_to_serialized_json
  end

  def show
    user_game = @current_user.user_games.find_by(id: params[:id])
    render json: UserGameSerializer.new(user_game).show_to_serialized_json
  end

  def create
    if !@current_user.user_games.find_by(game_id: params[:game][:id])
      @current_user.user_games.create(game: Game.find_by(id: params[:game][:id]))
      render json: { success: "Game added to collection" }
    else
      return { error: "Game already in collection" }
    end
  end

  def destroy
  end

 end