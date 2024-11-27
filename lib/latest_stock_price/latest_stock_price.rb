require 'net/http'
require 'uri'
require 'json'

module LatestStockPrice
  class Client
    BASE_URL = "https://latest-stock-price.p.rapidapi.com/any"

    def get_prices(identifiers)
      response = request_api(identifiers)
      parse_response(response)
    end

    def get_price(identifier)
      response = request_api(indentifier)
      parse_response(response)
    end

    def get_price_all
      response = request_api()
      parse_response(response)
    end

    private

    def request_api(identifiers = nil)
      if identifiers.is_a?(Array)
        # Join the identifiers array into a comma-separated string with '%2C%20' encoding
        query_string = "?Identifier=#{identifiers.join('%2C%20')}"
      elsif identifiers
        # If a single identifier is passed, use it directly
        query_string = "?Identifier=#{identifiers}"
      else
        query_string = ""
      end

      url = URI(BASE_URL + query_string)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = 'dcbdb71fbemsh6a18699d4a3229ap100341jsn43e5a33cda83'
      request["x-rapidapi-host"] = 'latest-stock-price.p.rapidapi.com'

      response = http.request(request)
      response.body
    end

    def parse_response(response_body)
      JSON.parse(response_body, symbolize_names: true)
    end
  end
end
