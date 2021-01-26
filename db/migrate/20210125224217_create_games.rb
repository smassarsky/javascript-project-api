class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :publisher
      t.string :release_date
      t.string :genre

      t.timestamps
    end
  end
end
