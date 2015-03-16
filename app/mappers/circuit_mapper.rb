require 'uri'

class CircuitMapper < BaseMapper
  provides :name, :url, :lat, :lng, :country, :locality

  private

  def name
    data.fetch("circuitName")
  end

  def url
    URI(data.fetch("url"))
  end

  def lat
    location.fetch("lat").to_f
  end

  def lng
    location.fetch("long").to_f
  end

  def country
    location.fetch("country")
  end

  def locality
    location.fetch("locality")
  end

  def location
    @location ||= data.fetch("Location")
  end
end
