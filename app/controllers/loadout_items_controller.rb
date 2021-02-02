class LoadoutItemsController < ApplicationController

  def index
    if params[:loadout_id]
      loadout = Loadout.find_by(id: params[:loadout_id])
      if exists_and_owner?(loadout)
        render json: LoadoutSerializer.new(loadout).items_to_serialized_json
      end
    end
  end

  def create
    byebug
    loadout = Loadout.find_by(id: params[:loadout_id])
    if params[:item_id]
      existing_item = Item.find_by(id: params[:item_id])
      if exists_and_owner?(loadout) && exists_and_owner?(existing_item)
        loadout.loadout_items.build(item: existing_item, quantity: params[:item][:quantity])
        if loadout.save
          render json: ItemSerializer.new(existing_item).new_to_serialized_json
        else
          render json: { error: loadout.errors.full_messages }
        end
      end
    else
      if exists_and_owner?(loadout)
        loadout_item = loadout.loadout_items.build(loadout_item_params)
        if loadout_item.save
          render json: LoadoutItemSerializer.new(loadout_item).to_serialized_json
        else
          render json: { error: loadout_item.errors.full_messages }
        end
      end
    end
  end

  def update
    loadout_item = LoadoutItem.find_by(id: params[:id])
    if exists_and_owner?(loadout_item)
      if loadout_item.update(loadout_item_params)
        render json: LoadoutItemSerializer.new(loadout_item).to_serialized_json
      else
        render json: { error: loadout_item.errors.full_messages }
      end
    end
  end

  def destroy
    loadout_item = LoadoutItem.find_by(id: params[:id])
    if exists_and_owner?(loadout_item)
      loadout_item.destroy
      render json: { success: "Loadout Item Deleted" }
    end
  end

  private

  def loadout_item_params
    params.require(:loadout_item).permit(:quantity, item_attributes: [:id, :name, :note, :user_game_id])
  end

  def item_params
    params.require(:item).permit(:name, :note)
  end

 end