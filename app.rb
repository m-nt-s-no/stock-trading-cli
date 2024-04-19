class App
  attr_accessor :balance, :account, :stocks

  #initialize account with $10,000 balance
  #0 stocks in account
  #list of ten fake stocks with prices
  def initialize
    @balance = 10000
    @account = {} 
    @stocks = {"GB"=> {"name"=> "Globo Bank", "price"=> 200, "variance"=> [-8, 10]},
               "TT"=> {"name"=> "TechTastic", "price"=> 500, "variance"=> [-40, 50]},
               "OSC"=> {"name"=> "OldSkool Corp", "price"=> 100, "variance"=> [-1, 2]},
               "TTI"=> {"name"=> "Tasty Treats Inc", "price"=> 50, "variance"=> [-5, 5]},
               "FBN"=> {"name"=> "FlyByNight Airlines", "price"=> 125, "variance"=> [-10, 8]},
               "MMJ"=> {"name"=> "Medical MumboJumbo", "price"=> 400, "variance"=> [-80, 80]},
               "EQ"=> {"name"=> "Equestrian Coffee Co", "price"=> 40, "variance"=> [-2, 3]},
               "MAX"=> {"name"=> "Max's Flying Cars", "price"=> 250, "variance"=> [-50, 40]},
               "FUN"=> {"name"=> "Funtime Toys", "price"=> 75, "variance"=> [-5, 5]},
               "SD"=> {"name"=> "Specific Dynamics", "price"=> 150, "variance"=> [-10, 10]}}
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
      if (val["price"] > 1) && (diff > 0) #make sure price doesn't go below $1
        val["price"] = val["price"] + diff
      end
    end
  end

  def buy_or_sell_prompt(action)
    pp "Type the ticker symbol of the stock you want to #{action}, and the number of shares"
    puts "\n"
    pp "like this: GB 1"
  end

  def validate(input, option)
    input_array = input.split
    #test for anomalous input length
    if input_array.length != 2
      return false
    end
    #test that first element of input is a valid ticker symbol
    if self.stocks.keys.include?(input_array[0]) == false 
      return false
    end
    #test that second element of input is a valid integer
    if input_array[1].to_i > 0
      return false
    end

    if option == "1"
      #make sure buy amount is less than or equal to account balance
    elsif option == "2"
      #make sure stock being sold is in user's account
      #make sure number of shares being sold <= number of shares in account
    end
  end
  
  #loop: 
  #show balance
  #offer 3 options: buy, sell, exit
  #at end of each loop iteration, call update_prices
  def run
    pp "Welcome to the CLI Stock Trading App!"
    puts "\n"
    while true do
      pp "Here is your balance: " + self.balance.to_s
      puts "\n"
      pp "Here are the latest prices:"
      puts "\n"
      self.stocks.each do |stock|
        k, v = stock
        pp "name: " + v["name"] + ", ticker: " + k + ", price: " + v["price"].to_s
      end
      pp "Choose one of three options:"
      puts "\n"
      pp "Type 1 to buy, 2 to sell, or 3 to exit"

      option = gets.chomp
      if option == "1"
        self.buy_or_sell_prompt("buy")
        input = gets.chomp
        #if validate(input, option)
          #stock_to_buy, amount_to_buy = process(input)
          #self.buy(stock_to_buy, amount_to_buy)
        #end
      elsif option == "2"
        self.buy_or_sell_prompt("sell")
        input = gets.chomp
        #if validate(input, option)
          #stock_to_buy, amount_to_buy = process(input)
          #self.buy(stock_to_buy, amount_to_buy)
        #end
      elsif option == "3"
        pp "Exiting app. Have a good one!"
        break
      else
        pp "Sorry, that is not a valid option"
      end
      self.update_prices
    end
  end
end

pp "hello".to_i, "you".to_i
#new_app = App.new
#new_app.run
