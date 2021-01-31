class Loadout < ApplicationRecord
  belongs_to :user_game
  has_one :user, through: :user_game

  has_many :loadout_tasks
  has_many :tasks, through: :loadout_tasks

  has_many :loadout_items
  has_many :items, through: :loadout_items
  has_many :recipes, through: :items
  has_many :ingredients, through: :recipes

  validate :name_unique_per_usergame

  def name_unique_per_usergame
    errors.add(:name, "already used") if user_game.loadouts.find_by(name: name)
  end

end