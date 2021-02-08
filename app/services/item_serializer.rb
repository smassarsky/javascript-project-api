class ItemSerializer

  def initialize(item_obj)
    @item = item_obj
  end

  def truncated_to_serialized_json
    options = {
      only: [:id, :name, :note]
    }
    @item.to_json(options)
  end

  def new_to_serialized_json
    options = {
      only: [:id, :name, :quantity, :note]
    }
    @item.to_json(options)
  end

  def reagent_to_serialized_json
    options = {
      only: [:id, :name]
    }
    @item.to_json(options)
  end

  def items_to_serialized_json
    options = {
      only: [:id, :name, :quantity, :note],
      include: [:ingredients]
    }
    @item.to_json(options)
  end

end