class LoadoutItemSerializer

  def initialize(loadout_item_obj)
    @loadout_item = loadout_item_obj
  end

  def to_serialized_json
    puts @loadout_item
    options = {
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
    @loadout_item.to_json(options)
  end

end