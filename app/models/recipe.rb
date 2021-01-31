class Recipe < ApplicationRecord
  belongs_to :item
  has_one :user, through: :item

  has_many :ingredients
end