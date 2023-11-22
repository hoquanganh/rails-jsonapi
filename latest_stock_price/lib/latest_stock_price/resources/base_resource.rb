require 'httparty'

module LatestStockPrice
  module Resources
    class BaseResource
      include HTTParty

      def initialize(client)
        @client = client
      end

      def get(path)
        response = HTTParty.get(url_for(path), headers: headers)
        JSON.parse(response.body)
      end

      protected

      def str_ids(ids)
        Array(ids).join(',')
      end

      private

      def url_for(path)
        URI.join(@client.base_url, path)
      end

      def headers
        { 'X-RapidAPI-Key' => @client.api_token }
      end
    end
  end
end
