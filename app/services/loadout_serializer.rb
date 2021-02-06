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

  def items_to_serialized_json
    options = {
      only: [:id],
      include: {
        loadout_items: {
          include: {
            item: {
              include: {
                ingredients: {
                  include: {
                    reagent: {
                      only: [:id, :name, :note]
                    }
                  },
                  only: [:id, :quantity]
                }
              },
              only: [:id, :name, :note]
            }
          },
          only: [:id, :quantity]
        }
      },
      only: [:id]
    }
    @loadout.to_json(options)
  end

  def to_serialized_json
    options = {

    }
    @loadout.to_json(options)
  end


  # def the_items
  #   LoadoutItemSerializer.new(@loadout.loadout_items).to_serialized_json
  # end

end