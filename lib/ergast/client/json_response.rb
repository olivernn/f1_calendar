module Ergast
  module Client
    class JSONResponse < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do |r|
          response = r[:response]
          if env[:response_headers]["Content-Type"] =~ /json/
            response.env[:body] = JSON.parse(response.env[:body]) if response.env[:body].present?
          end
        end
      end
    end
  end
end
