class FixLastMigration < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.integer :item_id
    end
    rename_column :item_ingredients, :item_id, :recipe_id
    rename_column :item_ingredients, :ingredient_id, :item_id
    rename_table :item_ingredients, :ingredients
  end
end
