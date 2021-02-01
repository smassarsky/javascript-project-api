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
    loadout = Loadout.find_by(id: params[:loadout_id])
    if params[:item_id]
      existing_item = Item.find_by(id: params[:item_id])
      if exists_and_owner?(loadout) && exists_and_owner?(existing_item)
        existing_item.loadout_items.build(loadout: loadout, quantity: params[:item][:quantity])
        if existing_item.save
          render json: ItemSerializer.new(existing_item).new_to_serialized_json
        else
          render json: { error: existing_item.errors.full_messages }
        end
      end
    else
      if exists_and_owner?(loadout)
        new_item = Item.new(item_params)
        new_item.user_game = loadout.user_game
        new_item.loadout_items.build(loadout: loadout, quantity: params[:item][:quantity])
        if new_item.save
          render json: ItemSerializer.new(new_item).new_to_serialized_json
        else
          render json: { error: new_item.errors.full_messages }
        end
      end
    end
  end

  def destroy

  end

  private

  def item_params
    if params[:loadout_id]

    end
    params.require(:item).permit(:name, :note)
  end

 end