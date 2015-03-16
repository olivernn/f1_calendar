describe ResultMapper do
  let(:api_data) {
    {
      "FastestLap" => {
        "AverageSpeed" => {
          "speed" => "153.510",
          "units" => "kph"
        },
        "Time" => {
          "time" => "1:18.327"
        },
        "lap" => "74",
        "rank" => "6"
      },
      "Time" => {
        "time" => "2:15:52.056",
        "millis" => "8152056"
      },
      "status" => "Finished",
      "number" => "9",
      "position" => "1",
      "positionText" => "1",
      "points" => "25",
      "Driver" => {
        "nationality" => "German",
        "dateOfBirth" => "1985-06-27",
        "familyName" => "Rosberg",
        "givenName" => "Nico",
        "url" => "http://en.wikipedia.org/wiki/Nico_Rosberg",
        "code" => "ROS",
        "driverId" => "rosberg"
      },
      "Constructor" => {
        "nationality" => "German",
        "name" => "Mercedes",
        "url" => "http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One",
        "constructorId" => "mercedes"
      },
      "grid" => "1",
      "laps" => "78"
    }
  }

  context "rosberg" do
    it "provides attributes" do
      expect(ResultMapper.new(api_data)).to provide_attributes(
        driver_name: "Nico Rosberg",
        position: 1
      )
    end
  end
end
