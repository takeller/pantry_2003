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

  def summary
    @recipes.map do |recipe|
      {name: recipe.name,
       details:  {
         ingredients: recipe_ingredient_details(recipe),
         total_calories: recipe.total_calories
       }
      }
    end
  end

  def recipe_ingredient_details(recipe)
    recipe.ingredients.map do  |ingredient|
      # Sort by calories per ingredient in recipe
      recipe.ingredient_details(ingredient)
    end 
  end

end
