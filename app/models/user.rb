class User < ApplicationRecord
  has_secure_password

  has_many :user_games
  has_many :games, through: :user_games

  validates_presence_of :username, :password
  validates_uniqueness_of :username
end
