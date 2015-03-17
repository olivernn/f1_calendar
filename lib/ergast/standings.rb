module Ergast
  class Standings < Ergast::Collection
    data_path 'StandingsTable', 'StandingsLists', 0, 'DriverStandings'

    query :current, -> { "/current/driverStandings" }
  end
end
