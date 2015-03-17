require 'ergast/client/response'

module Ergast
  module Client
    class WrapResponse < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do |r|
          response = r[:response]
          response.env[:ergast_response] = Ergast::Client::Response.parse(response.env[:body])
        end
      end
    end
  end
end
