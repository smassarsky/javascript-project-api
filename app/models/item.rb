class Item < ApplicationRecord
  belongs_to :user_game
  has_one :user, through: :user_game

  has_many :loadout_items
  has_many :loadouts, through: :loadout_items

  has_many :ingredients
  has_many :reagents, through: :ingredients

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :user_game_id

end
