require 'ergast'

class Race
  def self.all(opts = {})
    season = opts.fetch(:season, :current)
    Ergast::Races.season(season)
      .lazy
      .map(&RaceMapper)
      .map do |attr|
        circuit = Circuit.new(attr.delete(:circuit))
        Race.new(attr.merge(circuit: circuit))
      end
  end

  attr_reader :id, :name, :number, :season, :starts_at, :url, :circuit

  def initialize(attrs = {})
    @id = attrs.fetch(:id)
    @name = attrs.fetch(:name)
    @number = attrs.fetch(:number)
    @season = attrs.fetch(:season)
    @starts_at = attrs.fetch(:starts_at)
    @url = attrs.fetch(:url)
    @circuit = attrs.fetch(:circuit)
  end

  def results
    @results ||= Ergast::Results
      .season_and_round(season, round)
      .lazy
      .map(&ResultMapper)
      .map do |attrs|
        Result.new(attrs)
      end
  end
end
