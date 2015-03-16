class Circuit

  attr_reader :name, :url, :lat, :lng, :country, :locality

  def initialize(attrs = {})
    @name = attrs.fetch(:name)
    @url = attrs.fetch(:url)
    @lat = attrs.fetch(:lat)
    @lng = attrs.fetch(:lng)
    @country = attrs.fetch(:country)
    @locality = attrs.fetch(:locality)
  end
end
