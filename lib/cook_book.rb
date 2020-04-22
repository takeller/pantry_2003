class CookBook

  attr_reader :recipes
  def initialize
    @recipes = Array.new
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients
    @recipes.map do |recipe|
      recipe.ingredient_names
    end.flatten.uniq 
  end
end
