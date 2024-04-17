require 'minitest/autorun'
require './app'

class TestApp < Minitest::Test

  #puts stock prices from app.stocks into array for easier comparison
  def get_stock_prices(stocks)
    output = []
    stocks.each do |stock|
      key, val = stock
      output.push(val["price"])
      end
    return output
  end

  def test_update_prices
    test_app = App.new
    prices_before_update = get_stock_prices(test_app.stocks)
    test_app.update_prices
    prices_after_update = get_stock_prices(test_app.stocks)
    assert_equal true, prices_before_update != prices_after_update, "error: update_prices did not alter stock prices"
  end
end
