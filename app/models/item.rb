class Item < ApplicationRecord
  belongs_to :user_game
  has_one :user, through: :user_game

  has_many :loadout_items
  has_many :loadouts, through: :loadout_items

  has_one :recipe
  has_many :ingredients, through: :recipe
  has_many :reagents, through: :recipe

end