require 'ergast'

class Race
  include Comparable

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

  def past?
    starts_at.past?
  end

  def <=>(other)
    starts_at <=> other.starts_at
  end

  def grid_positions
    return [] unless qualifying_complete?

    @grid_positions ||= Ergast::GridPositions
      .season_and_round(season, number)
      .lazy
      .map(&GridPositionMapper)
      .map { |attrs| GridPosition.new(attrs) }
      .sort
  end

  def results
    return [] unless past?

    @results ||= Ergast::Results
      .season_and_round(season, number)
      .lazy
      .map(&ResultMapper)
      .map { |attrs| Result.new(attrs) }
      .sort
  end

  private

  def qualifying_complete?
    starts_tomorrow? || starts_at.today? || starts_at.past?
  end

  def starts_tomorrow?
    tomorrow = Date.tomorrow
    (tomorrow.beginning_of_day..tomorrow.end_of_day).cover?(starts_at)
  end
end
