class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :reagent, class_name: "Item"
end