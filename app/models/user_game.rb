class UserGame < ApplicationRecord
  belongs_to :user
  belongs_to :game

  has_many :tasks

  has_many :loadouts

  has_many :items
  has_many :recipes, through: :items
  has_many :ingredients, through: :recipes

  validate :only_one_instance_of_game_per_user

  def only_one_instance_of_game_per_user
    if user.user_games.find_by(game: game)
      errors.add(:game, "is already in your collection!")
    end
  end

end