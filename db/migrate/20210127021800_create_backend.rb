class CreateBackend < ActiveRecord::Migration[6.0]
  def change

    create_table :user_games do |t|
      t.integer :user_id
      t.integer :game_id
    end

    create_table :tasks do |t|
      t.integer :user_game_id
      t.string :name
      t.text :description
    end

    create_table :loadouts do |t|
      t.integer :user_game_id
      t.string :name
    end

    create_table :loadout_tasks do |t|
      t.integer :loadout_id
      t.integer :task_id
    end

    create_table :items do |t|
      t.integer :user_game_id
      t.string :name
      t.string :description
    end

    create_table :loadout_items do |t|
      t.integer :loadout_id
      t.integer :item_id
      t.integer :quantity
    end
    
    create_table :recipes do |t|
      t.integer :item_id
    end

    create_table :ingredients do |t|
      t.integer :recipe_id
      t.integer :item_id
      t.integer :quantity
    end

  end
end
