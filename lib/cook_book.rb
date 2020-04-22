require 'pry'
class CookBook

  attr_reader :recipes, :date
  def initialize
    @recipes = Array.new
    @date = Date::today.strftime("%m-%d-%Y")
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients
    @recipes.map do |recipe|
      recipe.ingredient_names
    end.flatten.uniq
  end

  def highest_calorie_meal
    calories_by_recipe = @recipes.map do |recipe|
      [recipe, recipe.total_calories]
    end.to_h
    calories_by_recipe.max_by { |recipe, calories| calories }[0]
  end
end
