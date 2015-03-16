module Ergast
  module Client

    class ApiError < StandardError
      def initialize(message = nil, env = {})
        super(message)
        @env = env
      end
    end

    class BadRequest < ApiError ; end
    class ServiceUnavailable < ApiError ; end
    class NotFound < ApiError ; end

    class ErrorHandler < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do |env|
          raise BadRequest.new(error_message(env), env) if env[:status] == 400
          raise NotFound.new(error_message(env), env) if env[:status] == 404
          raise ServiceUnavailable.new(error_message(env), env) if env[:status] == 500
        end
      end

      private

      def error_message(env)
        "#{env[:method].to_s.upcase} #{env[:url]}"
      end
    end
  end
end
