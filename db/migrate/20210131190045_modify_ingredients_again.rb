class ModifyIngredientsAgain < ActiveRecord::Migration[6.0]
  def change
    rename_column :ingredients, :item_id, :reagent_id
  end
end
