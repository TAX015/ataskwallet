class StocksController < ApplicationController
  require_relative '../../lib/latest_stock_price/latest_stock_price.rb'
  layout "transaction"

  before_action :set_section, except: [:get_prices]

  def set_section
    client = LatestStockPrice::Client.new
    @stocks = client.get_price_all.sort_by { |stock| stock[:identifier] }
  end

  def index
  end

  def prices
  end

  def get_prices
    client = LatestStockPrice::Client.new
    selected_stocks = params[:identifiers].reject { |i| i.empty? }.join(",")
    @stocks = client.get_prices(selected_stocks)
  end
end
