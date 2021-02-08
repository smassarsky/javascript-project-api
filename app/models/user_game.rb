class UserGame < ApplicationRecord
  belongs_to :user
  belongs_to :game

  has_many :tasks, dependent: :destroy
  has_many :loadouts, dependent: :destroy
  has_many :items, dependent: :destroy

  validates_uniqueness_of :game_id, scope: :user_id
  # validate :only_one_instance_of_game_per_user

  # def only_one_instance_of_game_per_user
  #   if user.user_games.find_by(game: game)
  #     errors.add(:game, "is already in your collection!")
  #   end
  # end

end