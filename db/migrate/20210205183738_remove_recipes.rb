class RemoveRecipes < ActiveRecord::Migration[6.0]
  def change
    drop_table :recipes
    rename_column :ingredients, :recipe_id, :item_id
  end
end
