module Ergast
  class GridPositions < Ergast::Collection
    data_path 'RaceTable', 'Races', 0, 'QualifyingResults'

    query :season_and_round, ->(season, round) { "/#{season}/#{round}/qualifying" }
  end
end
