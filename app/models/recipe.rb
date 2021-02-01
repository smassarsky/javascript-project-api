class Recipe < ApplicationRecord
  belongs_to :item
  has_many :ingredients
  has_many :reagents, through: :ingredients
end