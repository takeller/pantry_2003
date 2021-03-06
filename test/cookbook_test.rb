require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
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

  def test_highest_calorie_meal
    add_ingredients
    add_recipes
    assert_equal @recipe2, @cookbook.highest_calorie_meal
  end

  def test_it_has_a_date
    # Test with date in the past so it works for more than 24 hours
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    cookbook1 = CookBook.new
    assert_equal "08-04-1995", cookbook1.date
  end

  def test_summary
    add_ingredients
    @cookbook.add_recipe(@recipe1)
    recipe3 = Recipe.new("Burger")
    ingredient3 = Ingredient.new(name: "Ground Beef", unit: "oz", calories: 100)
    ingredient4 = Ingredient.new(name: "Bun", unit: "g", calories: 1)
    recipe3.add_ingredient(ingredient3, 4)
    recipe3.add_ingredient(ingredient4, 100)
    @cookbook.add_recipe(recipe3)

    expected = [{:name=>"Mac and Cheese", :details=>{:ingredients=>[{:ingredient=>"Macaroni", :amount=>"8 oz"}, {:ingredient=>"Cheese", :amount=>"2 C"},  ], :total_calories=>440}},
    {:name=>"Burger", :details=>{:ingredients=>[{:ingredient=>"Ground Beef", :amount=>"4 oz"}, {:ingredient=>"Bun", :amount=>"100 g"}], :total_calories=>500}}]

    assert_equal expected, @cookbook.summary
  end

  def test_recipe_ingredient_details
    add_ingredients
    add_recipes
    expected = [{:ingredient=>"Cheese", :amount=>"2 C"}, {:ingredient=>"Macaroni", :amount=>"8 oz"}, ]
    assert_equal expected, @cookbook.recipe_ingredient_details(@recipe1)
  end
end
