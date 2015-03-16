module Ergast
  module Client
    class JSONResponse < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do
          if env[:response_headers]["Content-Type"] =~ /json/
            env[:body] = JSON.parse(env[:body]) if env[:body].present?
          end
        end
      end
    end
  end
end
