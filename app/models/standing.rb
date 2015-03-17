require 'ergast'

class Standing
  def self.current
    Ergast::Standings.current
      .lazy
      .map(&StandingMapper)
      .map do |attrs|
        Standing.new(attrs)
      end
  end

  attr_reader :driver_name, :position, :points

  def initialize(attrs = {})
    @driver_name = attrs.fetch(:driver_name)
    @position = attrs.fetch(:position)
    @points = attrs.fetch(:points)
  end

  def <=>(other)
    position <=> other.position
  end
end
