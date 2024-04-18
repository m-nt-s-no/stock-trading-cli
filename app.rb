class App
  attr_accessor :balance, :account, :stocks

  #initialize account with $10,000 balance
  #0 stocks in account
  #list of ten fake stocks with prices
  def initialize
    @balance = 10000
    @account = [] #info inside to have form {stock_name=> number_of_shares}
    @stocks = {"Globo Bank"=> {"ticker"=> "GB", "price"=> 200, "variance"=> [-8, 10]},
               "TechTastic"=> {"ticker"=> "TT", "price"=> 500, "variance"=> [-40, 50]},
               "OldSkool Corp"=> {"ticker"=> "OSC", "price"=> 100, "variance"=> [-1, 2]},
               "Tasty Treats Inc"=> {"ticker"=> "TTI", "price"=> 50, "variance"=> [-5, 5]},
               "FlyByNight Airlines"=> {"ticker"=> "FBN", "price"=> 125, "variance"=> [-10, 8]},
               "Medical MumboJumbo"=> {"ticker"=> "MMJ", "price"=> 400, "variance"=> [-80, 80]},
               "Equestrian Coffee Co"=> {"ticker"=> "TT", "price"=> 40, "variance"=> [-2, 3]},
               "Max's Flying Cars"=> {"ticker"=> "MAX", "price"=> 250, "variance"=> [-50, 40]},
               "Funtime Toys"=> {"ticker"=> "FUN", "price"=> 75, "variance"=> [-5, 5]},
               "Specific Dynamics"=> {"ticker"=> "TT", "price"=> 150, "variance"=> [-10, 10]}}
  end

  #buy method:
  #make sure stock being bought matches company names or ticker symbols
  #make sure buy amount is less than or equal to account balance
  #reduce balance by correct amount

  #sell method:
  #make sure stock being sold is in user's account
  #make sure number of shares being sold <= number of shares in account
  #credit balance with $ corresponding to stocks sold

  def update_prices
  #make sure price doesn't go below $1
  self.stocks.each do |stock|
    key, val = stock
    a, b = val["variance"]
    val["price"] = val["price"] + rand(a..b)
    end
  end 
  
  #loop: 
  #show balance
  #offer 3 options: buy, sell, exit
  #at end of each loop iteration, call update_prices
end
