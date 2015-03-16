module Ergast
  class Collection < Enumerator

    if Rails.env.test?
      COOL_OFF_PERIOD = 0
    else
      COOL_OFF_PERIOD = 2
    end

    def self.data_path(*parts)
      @data_path_parts = parts
    end

    def self.query(name, path)
      define_singleton_method name, ->(*args) {
        self.new(Ergast::Client.get(path.call(*args)))
      }
    end

    def initialize(response)
      @response = response
      @request_count = 0
      extract_data_from_response

      super() do |yielder|
        loop do
          yielder.yield item
        end
      end
    end

    private

    attr_accessor :response, :data, :request_count

    def item
      data.next
    rescue StopIteration
      raise StopIteration if response.last_page?

      fetch_next_page
      extract_data_from_response

      data.next
    end

    def extract_data_from_response
      path = self.class.instance_variable_get("@data_path_parts")
      self.data = response.data(*path).to_enum
    end

    def fetch_next_page
      enforce_cool_off_period do
        self.response = response.next_page
      end
    end

    def enforce_cool_off_period(&block)
      if request_count >= 3
        self.request_count = 0
        sleep COOL_OFF_PERIOD
      end

      block.call

      self.request_count = request_count + 1
    end
  end
end
