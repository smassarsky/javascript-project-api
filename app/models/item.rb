class Item < ApplicationRecord
  belongs_to :user_game
  has_one :user, through: :user_game

  has_many :loadout_items
  has_many :loadouts, through: :loadout_items

  has_one :recipe
  has_many :ingredients, through: :recipe
  has_many :reagents, through: :recipe

  validates_presence_of :name
  validate :only_one_instance_of_item_per_user_game, on: :create

  def only_one_instance_of_item_per_user_game
    if user_game.items.find_by(name: name)
      errors.add(:item, "already exists for this game")
    end
  end

end
