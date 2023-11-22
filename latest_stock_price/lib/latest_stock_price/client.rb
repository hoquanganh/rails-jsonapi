module LatestStockPrice
  class Client
    BASE_URL = 'https://latest-stock-price.p.rapidapi.com'

    def initialize(api_token, base_url=BASE_URL)
      @api_url = api_url
      @api_token = api_token
    end

    def price
      @price ||= LatestStockPrice::Resources::Price.new(self)
    end
  end
end
