module Ergast
  class Races < Ergast::Collection

    data_path 'RaceTable', 'Races'

    query :season, ->(year) { "/#{year}" }

  end
end
