class GenreSerializer

  def initialize(genre_obj)
    @genre = genre_obj
  end

  def to_serialized_json
    options = {
      only: [:name]
    }
    @company.to_json(options)
  end

end