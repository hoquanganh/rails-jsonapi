module LatestStockPrice
  module Resources
    class Price < BaseResource
      def get_price(indice, identifiers)
        get("/price?Indices=#{indice}&Identifier=#{str_ids(identifiers)}")
      end

      def get_prices(indices)
        get("/prices?Indices=#{str_ids(indices)}")
      end

      def get_price_all
        get("/any")
      end
    end
  end
end
