class HomeController < ApplicationController

def index
    @title = "SolidQueue"
    @top_sellers = Product.top_sellers
    @new_arrivals = Product.new_arrivals
    @best_deals = Product.best_deals
  end

end
