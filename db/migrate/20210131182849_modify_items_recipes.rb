class ModifyItemsRecipes < ActiveRecord::Migration[6.0]
  def change
    drop_table :recipes
    rename_column :items, :description, :note
    rename_column :ingredients, :item_id, :ingredient_id
    rename_column :ingredients, :recipe_id, :item_id
    rename_table :ingredients, :item_ingredients
  end
end
