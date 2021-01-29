class InvolvedCompany < ApplicationRecord
  belongs_to :game
  belongs_to :company

  scope :publisher, -> { where(publisher: true) }
  scope :developer, -> { where(developer: true) }
  scope :supporting, -> { where(supporting: true) }

end
