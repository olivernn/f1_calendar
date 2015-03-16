module Icalendar
  module Values
    class AppleStructuredLocation < Value

      attr_reader :address, :title, :lat, :lng

      def initialize(params = {})
        @address = params.fetch(:address)
        @title = params.fetch(:title)
        @lat = params.fetch(:lat)
        @lng = params.fetch(:lng)
      end

      def to_ical(*asdf)
        ";VALUE=URI;X-APPLE-RADIUS=144;X-TITLE=#{title}:geo:#{lat},#{lng}"
      end
    end
  end
end
