require 'uri'
require 'time'

class RaceMapper < BaseMapper

  provides :id, :number, :name, :starts_at, :url, :season, :circuit

  private

  def id
    "#{season}/#{number}"
  end

  def number
    data.fetch("round").to_i
  end

  def name
    data.fetch("raceName")
  end

  def starts_at
    date = data.fetch("date")
    time = data.fetch("time")

    Time.parse("#{date} #{time}").utc
  end

  def url
    URI(data.fetch("url"))
  end

  def season
    data.fetch("season")
  end

  def circuit
    CircuitMapper.new(data.fetch("Circuit")).to_h
  end
end
