class NextRacePresenter < RacePresenter
  class GridPositionPresenter
    def self.to_proc
      proc { |grid_position| new(grid_position).to_s }
    end

    def initialize(grid_position)
      @grid_position = grid_position
    end

    def to_s
      "#{ordinalized_position}: #{driver}"
    end

    private

    attr_reader :result

    def ordinalized_position
      grid_position.position.rjust(2)
    end

    def driver
      grid_position.driver_name
    end
  end

  class StandingPresenter
    def self.to_proc
      proc { |standing| new(standing).to_s }
    end

    def initialize(standing)
      @standing = standing
    end

    def to_s
      "#{ordinalized_position}: #{driver} (#{points} pts)"
    end

    private

    attr_reader :standing

    def ordinalized_position
      standing.position.ordinalize.rjust(4)
    end

    def driver
      standing.driver_name
    end

    def points
      standing.points
    end
  end

  private

  def description
    "CHAMPIONSHIP STANDINGS\n\n#{championship_standings}\n\nGRID POSITIONS\n\n#{grid_positions}"
  end

  def grid_positions
    race.grid_positions
      .map(&GridPositionPresenter)
      .to_a
      .join("\n")
  end

  def championship_standings
    Standing.current
      .map(&StandingPresenter)
      .to_a
      .join("\n")
  end
end
