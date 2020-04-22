require 'minitest/autorun'
require 'minitest/pride'
require './lib/pantry'
require './lib/ingredient'

class PantryTest < MiniTest::Test

  def setup
    @ingredient1 = Ingredient.new({name: "Cheese", unit: "oz", calories: 50})
    @ingredient2 = Ingredient.new("Macaroni", "oz", 200)
    @pantry = Pantry.new
  end

  def test_it_exists
    assert_instance_of Pantry, @pantry
  end

  def test_stock_is_empty_by_default
    assert_equal Hash.new, @pantry.stock
  end

  def test_stock_check
    assert_equal 0, @pantry.stock_check(@ingredient1)
  end

  def test_restock
    @pantry.restock(@ingredient1, 5)
    @pantry.restock(@ingredient1, 10)
    assert_equal ({@ingredient1 => 15}), @pantry.stock
    @pantry.restock(@ingredient2, 7)
    expected = {
      @ingredient1 => 15,
      @ingredient2 => 7
    }
    assert_equal expected, @pantry.stock 
  end
end
