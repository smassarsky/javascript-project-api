class Task < ApplicationRecord
  belongs_to :user_game
  has_one :user, through: :user_game
  
  has_many :loadout_tasks
  has_many :loadouts, through: :loadout_tasks
end