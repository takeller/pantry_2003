class CookBook

  attr_reader :recipes
  def initialize
    @recipes = Array.new
  end

  def add_recipe(recipe)
    @recipes << recipe 
  end
end
