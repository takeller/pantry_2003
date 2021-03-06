require 'pry'
class Recipe

  attr_reader :name, :ingredients_required
  def initialize(name)
    @name = name
    @ingredients_required = Hash.new(0)
  end

  def add_ingredient(ingredient, amount)
    @ingredients_required[ingredient] += amount
  end

  def ingredients
    @ingredients_required.keys
  end

  def ingredient_names
    @ingredients_required.keys.map { |ingredient| ingredient.name }
  end

  def total_calories
    @ingredients_required.map do |ingredient, quantity|
      ingredient.calories * quantity
    end.sum
  end

  def ingredient_details(ingredient)
    {
      ingredient: ingredient.name,
      amount: @ingredients_required[ingredient].to_s + " " + ingredient.unit
    }
  end
end
