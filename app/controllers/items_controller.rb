class ItemsController < ApplicationController

  def index
    if params[:loadout_id]
      loadout = Loadout.find_by(id: params[:loadout_id])
      if exists_and_owner?(loadout)
        render json: LoadoutSerializer.new(loadout).items_to_serialized_json
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