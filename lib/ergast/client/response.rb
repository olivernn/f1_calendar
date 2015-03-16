module Ergast
  module Client
    class Response

      class MissingData < StandardError ; end
      class NoMorePages < StandardError ; end

      def self.parse(raw)
        self.new(
          url: raw['MRData']['url'],
          limit: raw['MRData']['limit'].to_i,
          offset: raw['MRData']['offset'].to_i,
          total: raw['MRData']['total'].to_i,
          payload: raw['MRData']
        )
      end

      attr_reader :url, :limit, :offset, :total, :payload

      def initialize(attrs = {})
        @url = attrs[:url]
        @limit = attrs[:limit]
        @offset = attrs[:offset]
        @total = attrs[:total]
        @payload = attrs[:payload]
      end

      def data(*keys)
        keys.inject(payload) { |memo, key| memo.fetch(key) }
      rescue IndexError
        raise MissingData
      end

      def next_page
        raise NoMorePages if last_page?
        Ergast::Client.get(path, limit: Ergast::Client::LIMIT, offset: offset + Ergast::Client::LIMIT)
      end

      def last_page?
        offset + Ergast::Client::LIMIT >= total
      end

      private

      def path
        url.gsub(Ergast::Client::HOST, '').gsub(Ergast::Client::PATH, '').gsub(Ergast::Client::FORMAT, '')
      end
    end
  end
end
