class ItemsController < ApplicationController

  def index
    user_game = UserGame.find_by(id: params[:user_game_id])
    if exists_and_owner?(user_game)
      items = Item.where(user_game: user_game)
      if params[:ingredients_also]
        render json: ItemSerializer.new(items).full_to_serialized_json
      else
        render json: ItemSerializer.new(items).truncated_to_serialized_json
      end
    end
  end

  def show

  end

  def create

  end

  def remove

  end

  def destroy
    item = item.find_by(id: params[:id])
    if exists_and_owner?(item)

    end
  end

  private

  def item_params
    if params[:loadout_id]

    end
    params.require(:item).permit(:name, :note)
  end

 end