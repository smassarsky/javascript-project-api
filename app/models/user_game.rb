class UserGame < ApplicationRecord
  belongs_to :user
  belongs_to :game

  has_many :tasks

  has_many :loadouts

  has_many :items
  has_many :recipes, through: :items
  has_many :ingredients, through: :recipes

end