class IngredientSerializer

  def initialize(ingredient_obj)
    @ingredient = ingredient_obj
  end

  def to_serialized_json
    options = {
      include: [:item],
      only: [:quantity]
    }
    @ingredient.to_json(options)
  end

  private

  def item
    ItemSerializer.new(@ingredient.reagent).reagent_to_serialized_json
  end

end