class CompanySerializer

  def initialize(company_obj)
    @company = company_obj
  end

  def to_serialized_json
    options = {
      only: [:id, :name]
    }
    @company.to_json(options)
  end

end