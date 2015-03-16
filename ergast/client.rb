require 'ergast/client/json_response'
require 'ergast/client/error_handler'
require 'ergast/client/wrap_response'
require 'ergast/client/instrument'

module Ergast
  module Client
    extend self

    PATH = "/api/f1"
    HOST = "http://ergast.com"
    FORMAT = ".json"
    LIMIT = 50

    Faraday.register_middleware :response, {
      json_response: -> { Ergast::Client::JSONResponse },
      error_handler: -> { Ergast::Client::ErrorHandler },
      wrap_response: -> { Ergast::Client::WrapResponse },
    }

    Faraday.register_middleware :request, {
      instrument: -> { Ergast::Client::Instrument },
    }

    def get(path, query = {})
      request(:get, expand_path(path, default_query.merge(query))).env[:ergast_response]
    end

    private

    def default_query
      { limit: LIMIT }
    end

    def expand_path(path, query)
      "".tap do |url|
        url << PATH
        url << path
        url << FORMAT
        url << "?" + query.to_query unless query.empty?
      end
    end

    def request(method, full_path)
      connection.send(method) do |req|
        req.url full_path
      end
    end

    def connection
      @connection ||= Faraday.new(url: HOST) do |faraday|
        faraday.request :instrument
        faraday.response :wrap_response
        faraday.response :json_response
        faraday.response :error_handler
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
