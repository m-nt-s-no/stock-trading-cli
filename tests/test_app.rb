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

  def test_buy
    test_app = App.new
    assert_equal 10000, test_app.balance, "Error: starting balance does not equal 10,000"
    test_stock = "Globo Bank"
    test_app.buy(test_stock, 1)
    assert_equal 10000 - test_app.stocks[test_stock]["price"], test_app.balance, "Error: incorrect amount deducted from balance"
    assert_equal true, test_app.account.include?({test_stock=> 1}), "Error: stock purchased but not included in account"

    test_app.buy(test_stock, 1)
    assert_equal 10000 - test_app.stocks[test_stock]["price"] - test_app.stocks[test_stock]["price"], test_app.balance, "Error: incorrect amount deducted from balance"
    assert_equal true, test_app.account.include?({test_stock=> 2}), "Error: additional share purchased but not included in account"
  end

  def test_sell
    test_app = App.new
    test_stock_1 = "Globo Bank"
    test_stock_2 = "FunTime Toys"
    test_app.account.push({test_stock_1=> 1})
    test_app.account.push({test_stock_2=> 2})

    test_app.sell(test_stock_1, 1)
    assert_equal 10000 + test_app.stocks[test_stock_1]["price"], test_app.balance, "Error: incorrect amount credited to balance"
    assert_equal false, test_app.account.include?({test_stock_1=> 1}), "Error: stock remains in account despite being sold"

    test_app.sell(test_stock_2, 1)
    assert_equal 10000 + test_app.stocks[test_stock_1]["price"] + test_app.stocks[test_stock_2]["price"], test_app.balance, "Error: incorrect amount credited to balance"
    assert_equal true, test_app.account.include?({test_stock_2=> 1}), "Error: incorrect number of shares remain in account"
  end
end
