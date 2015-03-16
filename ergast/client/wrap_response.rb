require 'ergast/client/response'

module Ergast
  module Client
    class WrapResponse < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do
          env[:ergast_response] = Ergast::Client::Response.parse(env[:body])
        end
      end
    end
  end
end
