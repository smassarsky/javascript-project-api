class Game < ApplicationRecord
  has_many :game_genres
  has_many :genres, through: :game_genres
  has_many :involved_companies
  has_many :companies, through: :involved_companies
end
