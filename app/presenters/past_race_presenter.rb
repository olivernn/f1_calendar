class PastRacePresenter < RacePresenter

  class ResultPresenter
    def self.to_proc
      proc { |result| new(result).to_s }
    end

    def initialize(result)
      @result = result
    end

    def to_s
      "#{ordinalized_position}: #{driver}"
    end

    private

    attr_reader :result

    def ordinalized_position
      result.position.ordinalize.rjust(4)
    end

    def driver
      result.driver_name
    end
  end

  private

  def description
    "RESULTS\n\n#{results}"
  end

  def results
    race.results
      .map(&ResultPresenter)
      .join("\n")
  end

end
