class LoadoutSerializer

  def initialize(loadout_obj)
    @loadout = loadout_obj
  end

  def new_to_serialized_json
    options = {
      only: [:id, :name]
    }
    @loadout.to_json(options)
  end

  def to_serialized_json
    options = {

    }
    @loadout.to_json(options)
  end

end