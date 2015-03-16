class Result
  include Comparable

  attr_reader :driver_name, :position

  def initialize(attrs = {})
    @driver_name = attrs.fetch(:driver_name)
    @position = attrs.fetch(:position)
  end

  def <=>(other)
    position <=> other.position
  end
end
