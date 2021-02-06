class Ingredient < ApplicationRecord
  belongs_to :item
  belongs_to :reagent, class_name: "Item"

  accepts_nested_attributes_for :reagent

  validates_presence_of :quantity
  validates_uniqueness_of :reagent_id, scope: :item_id

end