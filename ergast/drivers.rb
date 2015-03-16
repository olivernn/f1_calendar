module Ergast
  class Drivers < Ergast::Collection

    data_path 'DriverTable', 'Drivers'

    query :all, -> { '/drivers' }
    query :year, ->(year) { "/#{year}/drivers" }

  end
end
