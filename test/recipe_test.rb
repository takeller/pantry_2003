require 'minitest/autorun'
require 'minitest/pride'
require './lib/recipe'
require './lib/ingredient'
require 'pry'

class RecipeTest < MiniTest::Test

  def setup
    @ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    @ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    @ingredient3 = Ingredient.new({name: "Ground Beef", unit: "oz", calories: 100})
    @ingredient4 = Ingredient.new({name: "Bun", unit: "g", calories: 75})
    @recipe1 = Recipe.new("Mac and Cheese")
    @recipe2 = Recipe.new("Cheese Burger")
  end

  def add_ingredients
    @recipe1.add_ingredient(@ingredient1, 2)
    @recipe1.add_ingredient(@ingredient2, 8)
    @recipe2.add_ingredient(@ingredient1, 2)
    @recipe2.add_ingredient(@ingredient3, 4)
    @recipe2.add_ingredient(@ingredient4, 1)
  end

  def test_it_exists
    assert_instance_of Recipe, @recipe1
  end

  def test_it_has_a_name
    assert_equal "Mac and Cheese", @recipe1.name
  end

  def test_ingredients_required_is_empty_by_default
    assert_equal Hash.new, @recipe1.ingredients_required
  end

  def test_ingredients_is_empty_by_default
    assert_equal Array.new, @recipe1.ingredients
  end

  def test_add_ingredient
    @recipe1.add_ingredient(@ingredient1, 2)
    @recipe1.add_ingredient(@ingredient1, 4)
    @recipe1.add_ingredient(@ingredient2, 8)
    expected = {
      @ingredient1 => 6,
      @ingredient2 => 8
    }

    assert_equal expected, @recipe1.ingredients_required
  end

  def test_ingredients
    add_ingredients
    assert_equal [@ingredient1, @ingredient2], @recipe1.ingredients
  end

  def test_ingredient_names
    add_ingredients 
    assert_equal ["Cheese", "Macaroni"], @recipe1.ingredient_names
  end

  def test_total_calories
    add_ingredients
    assert_equal 440, @recipe1.total_calories
    assert_equal 675, @recipe2.total_calories
  end
end
