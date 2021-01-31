class LoadoutsController < ApplicationController

  def show
    byebug
  end

  def create
    user_game = UserGame.find_by(id: params[:user_game_id])
    if exists_and_owner?(user_game)
      loadout = Loadout.new(loadout_params)
      if loadout.save
        render json: LoadoutSerializer.new(loadout).new_to_serialized_json
      else
        render json: { error: loadout.errors.full_messages }, status: 400
      end
    end
  end

  def update
    loadout = Loadout.find_by(id: params[:id])
    if exists_and_owner?(loadout)
      if loadout.update(loadout_params)
        render json: LoadoutSerializer.new(loadout).new_to_serialized_json
      else
        render json: { error: loadout.errors.full_messages }, status: 400
      end
    end
  end

  def destroy
    loadout = Loadout.find_by(id: params[:id])
    if exists_and_owner?(loadout)
      loadout.destroy
      render json: { success: "Loadout deleted!" }
    end
  end
  
  private

  def loadout_params
    params.require(:loadout).permit(:user_game_id, :name)
  end

 end