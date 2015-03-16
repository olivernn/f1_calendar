module Ergast
  module Client
    class Instrument < Faraday::Middleware

      attr_reader :prefix

      def initialize(app, opts = {})
        super(app)
        @prefix = opts.fetch(:prefix, 'ergast')
      end

      def call(env)
        res = nil
        raised_exception = nil
        ActiveSupport::Notifications.instrument("#{prefix}.request", filtered(env.dup)) do
          begin
            res = @app.call(env)
          rescue Exception => e
            raised_exception = e
          end
        end
        res
      ensure
        ActiveSupport::Notifications.instrument("#{prefix}.response", filtered(env.dup))
        raise raised_exception if raised_exception
      end

      private

      # Filter out sensitive attributes such as "password" in Rails logs
      def filtered(env)
        @filter ||= ActionDispatch::Http::ParameterFilter.new(Rails.application.config.filter_parameters)
        @filter.filter(env)
      end
    end
  end
end
