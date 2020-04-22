require 'minitest/autorun'
require 'minitest/pride'
require './lib/recipe'
require './lib/ingredient'
require './lib/pantry'
require './lib/cook_book'

class CookbookTest < MiniTest::Test

  def setup
    @ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    @ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    @ingredient3 = Ingredient.new({name: "Ground Beef", unit: "oz", calories: 100})
    @ingredient4 = Ingredient.new({name: "Bun", unit: "g", calories: 75})

    @recipe1 = Recipe.new("Mac and Cheese")
    @recipe2 = Recipe.new("Cheese Burger")

    @pantry = Pantry.new
    @cookbook = CookBook.new
  end

  def add_ingredients
    @recipe1.add_ingredient(@ingredient1, 2)
    @recipe1.add_ingredient(@ingredient2, 8)
    @recipe2.add_ingredient(@ingredient1, 2)
    @recipe2.add_ingredient(@ingredient3, 4)
    @recipe2.add_ingredient(@ingredient4, 1)
  end

  def add_recipes
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)
  end

  def test_it_has_no_recipes_by_default
    assert_equal Array.new, @cookbook.recipes
  end

  def test_add_recipe
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)
    expected = [@recipe1, @recipe2]
    assert_equal expected, @cookbook.recipes
  end

  def test_ingredients
    add_ingredients
    add_recipes
    expected = ["Cheese", "Macaroni", "Ground Beef", "Bun"]

    assert_equal expected, @cookbook.ingredients
  end


end
