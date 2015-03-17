module Ergast
  module Client
    class Cache < Faraday::Middleware
      def call(env)
        cache_key = env[:url]

        if cached_env = Rails.cache.read(cache_key)
          return Faraday::Response.new(cached_env)
        end

        res = @app.call(env)

        unless empty_results?(res.env[:body])
          Rails.cache.write(cache_key, res.env, expires_in: 7.days.to_i)
        end

        res
      end

      private

      def empty_results?(body)
        body
          .fetch("MRData", {})
          .fetch("total", 0)
          .to_i
          .zero?
      end
    end
  end
end
