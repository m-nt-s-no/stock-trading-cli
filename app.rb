class App
  attr_accessor :balance, :account, :stocks

  #initialize account with $10,000 balance
  #0 stocks in account
  #list of ten fake stocks with prices
  def initialize
    @balance = 10000
    @account = {} 
    @stocks = {"GB"=> {"name"=> "Globo Bank", "price"=> 200, "variance"=> [-8, 10], "price change"=> 0},
               "TT"=> {"name"=> "TechTastic", "price"=> 500, "variance"=> [-40, 50], "price change"=> 0},
               "OSC"=> {"name"=> "OldSkool Corp", "price"=> 100, "variance"=> [-1, 2], "price change"=> 0},
               "TTI"=> {"name"=> "Tasty Treats Inc", "price"=> 50, "variance"=> [-5, 5], "price change"=> 0},
               "FBN"=> {"name"=> "FlyByNight Airlines", "price"=> 125, "variance"=> [-10, 8], "price change"=> 0},
               "MMJ"=> {"name"=> "Medical MumboJumbo", "price"=> 400, "variance"=> [-80, 80], "price change"=> 0},
               "EQ"=> {"name"=> "Equestrian Coffee Co", "price"=> 40, "variance"=> [-2, 3], "price change"=> 0},
               "MAX"=> {"name"=> "Max's Flying Cars", "price"=> 250, "variance"=> [-50, 40], "price change"=> 0},
               "FUN"=> {"name"=> "Funtime Toys", "price"=> 75, "variance"=> [-5, 5], "price change"=> 0},
               "SD"=> {"name"=> "Specific Dynamics", "price"=> 150, "variance"=> [-10, 10], "price change"=> 0}}
  end

  def buy(stock, amount)
    if self.account.include?(stock)
      self.account[stock] = self.account[stock] + amount
    else
      self.account[stock] = amount
    end
    self.balance = self.balance - (self.stocks[stock]["price"] * amount)
  end

  def sell(stock, amount)
    if self.account[stock] >= amount
      self.account[stock] = self.account[stock] - amount
    end

    self.balance = self.balance + (self.stocks[stock]["price"] * amount)
    if self.account[stock] == 0
      self.account.delete(stock)
    end
  end

  def update_prices
    self.stocks.each do |stock|
      key, val = stock
      a, b = val["variance"]
      diff = rand(a..b)
      if (val["price"] > 1) && (val["price"] + diff > 0) #make sure price doesn't go below $1
        val["price change"] = diff
        val["price"] = val["price"] + diff
      end
    end
  end

  def buy_or_sell_prompt(action)
    puts "Type the ticker symbol of the stock you want to #{action}, and the number of shares"
    puts "\n"
    puts "like this: GB 1"
  end

  def validate(input, option)
    input_array = input.split
    #test for anomalous input length
    if input_array.length != 2
      return false
    end
    order, amount = input_array[0], input_array[1].to_i
    #test that first element of input is a valid ticker symbol
    if self.stocks.keys.include?(order) == false 
      return false
    end
    #test that second element of input is a valid integer
    if amount <= 0
      return false
    end

    if option == "1"
      #make sure buy amount is less than or equal to account balance
      if self.balance < (amount * self.stocks[order]["price"])
        return false
      else
        self.buy(order, amount)
      end
    elsif option == "2"
      #make sure stock being sold is in user's account
      #make sure number of shares being sold <= number of shares in account
      if self.account.keys.include?(order) == false || self.account[order] < amount
        return false
      else
        self.sell(order, amount)
      end
    end

    return true
  end
  
  #main loop: 
  #show balance
  #offer 4 options: buy, sell, show stocks in account, exit
  #at end of each loop iteration, call update_prices
  def trade
    puts "Welcome to the CLI Stock Trading App!"
    while true do
      puts "Here is your balance: " + self.balance.to_s
      puts "Here are the latest prices:"
      puts "\n"
      self.stocks.each do |stock|
        k, v = stock
        puts "name: " + v["name"] + ", ticker: " + k + ", price: " + v["price"].to_s + ", price change: " + v["price change"].to_s
      end
      puts "Choose one of three options:"
      puts "\n"
      puts "Type 1 to buy, 2 to sell, 3 to see your account, or 4 to exit."

      option = gets.chomp
      if option == "1"
        self.buy_or_sell_prompt("buy")
        input = gets.chomp
        if validate(input, option) == false
          puts "Sorry, your order could not be fulfilled"
        else
          puts "Your order has been fulfilled!"
        end
      elsif option == "2"
        self.buy_or_sell_prompt("sell")
        input = gets.chomp
        if validate(input, option) == false
          puts "Sorry, your order could not be fulfilled"
        else
          puts "Your order has been fulfilled!"
        end
      elsif option == "3"
        puts "Your account: "
        self.account.each do |stock|
          stock, amount = stock
          puts "Stock: #{stock}, amount: #{amount}, worth: #{amount * self.stocks[stock]["price"]}"
        end
      elsif option == "4"
        puts "Exiting app. Have a good one!"
        break
      else
        puts "Sorry, that is not a valid option"
      end
      self.update_prices
    end
  end
end