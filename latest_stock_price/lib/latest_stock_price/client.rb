module LatestStockPrice
  class Client
    BASE_URL = 'https://latest-stock-price.p.rapidapi.com'
    attr_reader :base_url, :api_token

    def initialize(api_token, base_url=BASE_URL)
      @base_url = base_url
      @api_token = api_token
    end

    def price
      @price ||= LatestStockPrice::Resources::Price.new(self)
    end
  end
end
