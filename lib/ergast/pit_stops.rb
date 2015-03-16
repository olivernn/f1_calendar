module Ergast
  class PitStops < Ergast::Collection
    data_path 'RaceTable', 'Races', 0, 'PitStops'

    query :season_and_round, ->(season, round) { "/#{season}/#{round}/pitstops" }
  end
end
