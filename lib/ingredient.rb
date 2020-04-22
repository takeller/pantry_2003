class Ingredient

  attr_reader :name, :unit, :calories
  def initialize(ingredient_info, unit = nil, calories = nil)
    if ingredient_info.class == Hash
      @name = ingredient_info[:name]
      @unit = ingredient_info[:unit]
      @calories = ingredient_info[:calories]
    else
      @name = ingredient_info
      @unit = unit
      @calories = calories
    end 
  end
end
