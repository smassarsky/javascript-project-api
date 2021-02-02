class LoadoutItem < ApplicationRecord
  belongs_to :loadout
  belongs_to :item
  has_one :user, through: :loadout

  accepts_nested_attributes_for :item

  validates_presence_of :quantity

end