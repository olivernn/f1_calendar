module Ergast
  class Results < Ergast::Collection
    data_path 'RaceTable', 'Races', 0, 'Results'

    query :season_and_round, ->(season, round) { "/#{season}/#{round}/results" }
  end
end
