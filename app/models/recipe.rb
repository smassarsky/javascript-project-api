class Recipe < ApplicationRecord
  belongs_to :item
  has_many :ingredients
end