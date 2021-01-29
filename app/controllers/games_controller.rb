class GamesController < ApplicationController

  def index
    games = Game.all
    render json: GameSerializer.new(games).index_to_serialized_json
  end

  def show
    game = Game.find_by(id: params[:id])
    render json: GameSerializer.new(game).show_to_serialized_json
  end

 end