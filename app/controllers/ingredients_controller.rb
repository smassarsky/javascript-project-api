class IngredientsController < ApplicationController

  def create
    item = Item.find_by(id: params[:ingredient][:item_id])
    if exists_and_owner?(item)
      new_ingredient = Ingredient.new(ingredient_params)
      byebug
      if new_ingredient.save
        render json: IngredientSerializer.new(new_ingredient).to_serialized_json
      else
        render json: { error: new_ingredient.errors.full_messages }
      end
    end
  end

  def update

  end

  def destroy

  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:item_id, :quantity, reagent_attributes: [:id, :name, :note, :user_game_id])
  end

 end