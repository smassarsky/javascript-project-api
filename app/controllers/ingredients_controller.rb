class IngredientsController < ApplicationController

  def create
    item = Item.find_by(id: params[:ingredient][:item_id])
    if exists_and_owner?(item)
      new_ingredient = Ingredient.new(ingredient_params)
      if new_ingredient.save
        render json: IngredientSerializer.new(new_ingredient).to_serialized_json
      else
        render json: { error: new_ingredient.errors.full_messages }
      end
    end
  end

  def update
    byebug
    ingredient = Ingredient.find_by(id: params[:id])
    if exists_and_owner?(ingredient)
      if ingredient.update(ingredient_params)
        render json: IngredientSerializer.new(ingredient).to_serialized_json
      else 
        render json: { error: ingredient.errors.full_messages }
      end
    end
  end

  def destroy
    ingredient = Ingredient.find_by(id: params[:id])
    if exists_and_owner?(ingredient)
      ingredient.destroy
      render json: { success: "Ingredient destroyed" }
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:item_id, :reagent_id, :quantity, reagent_attributes: [:id, :name, :note, :user_game_id])
  end

 end