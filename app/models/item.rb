class Item < ApplicationRecord
 belongs_to :user_game

 has_many :loadout_items
 has_many :loadouts, through: :loadout_items

 has_one :recipe
 has_many :ingredients, through: :recipe

end