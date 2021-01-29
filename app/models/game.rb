class Game < ApplicationRecord
  has_many :game_genres
  has_many :genres, through: :game_genres
  has_many :involved_companies
  has_many :companies, through: :involved_companies

  def publishers
    self.companies.where(id: self.involved_companies.publisher.pluck(:company_id))
  end

  def developers
    self.companies.where(id: self.involved_companies.developer.pluck(:company_id))
  end

  def supporting
    self.companies.where(id: self.involved_companies.supporting.pluck(:company_id))
  end

end
