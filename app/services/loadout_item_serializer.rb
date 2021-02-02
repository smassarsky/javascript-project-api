class LoadoutItemSerializer

  def initialize(loadout_item_obj)
    @loadout_item = loadout_item_obj
  end

  def to_serialized_json
    puts @loadout_item
    options = {
      include: [:item],
      except: [:loadout_id]
    }
    @loadout_item.to_json(options)
  end

  private

  def item
    ItemSerializer.new(@loadout_item.item).to_serialized_json
  end

end