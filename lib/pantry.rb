class Pantry

  attr_reader :stock
  def initialize
    @stock = Hash.new(0)
  end

  def restock(ingredient, amount)
    @stock[ingredient] += amount
  end

  def stock_check(ingredient)
    @stock[ingredient]
  end

  def enough_ingredients_for?(recipe)
    recipe.ingredients_required.each do |ingredient, amount_required|
      return false if stock_check(ingredient) < amount_required
    end
    true  
  end
end
