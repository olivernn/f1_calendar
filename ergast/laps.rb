module Ergast
  class Laps < Ergast::Collection
    data_path 'RaceTable', 'Races', 0, 'Laps'

    query :season_and_round, ->(season, round) { "/#{season}/#{round}/laps" }
  end
end
