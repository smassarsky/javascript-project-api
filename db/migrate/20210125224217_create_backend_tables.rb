class CreateBackendTables < ActiveRecord::Migration[6.0]
  def change
    create_table :twitch_tokens do |t|
      t.string :token

      t.timestamps
    end

    create_table :games do |t|
      t.integer :api_id
      t.string :name
      t.datetime :release_date
      t.string :url
      t.string :cover_url
      
      t.timestamps
    end

    create_table :companies do |t|
      t.integer :api_id
      t.string :name
      t.string :url
      t.datetime :start_date
    end

    create_table :involved_companies do |t|
      t.integer :api_id
      t.integer :game_id
      t.integer :company_id
      t.boolean :developer
      t.boolean :publisher
      t.boolean :supporting
    end

    create_table :genres do |t|
      t.integer :api_id
      t.string :name
    end

    create_table :game_genres do |t|
      t.integer :game_id
      t.integer :genre_id
    end

  end
end
