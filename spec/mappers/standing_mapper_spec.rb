describe StandingMapper do
  let(:data) do
    {
      "Constructors"=> [{
        "nationality"=>"German",
        "name"=>"Mercedes",
        "url"=>"http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One",
        "constructorId"=>"mercedes"
      } ],
      "Driver"=> {
       "nationality"=>"British",
       "dateOfBirth"=>"1985-01-07",
       "familyName"=>"Hamilton",
       "givenName"=>"Lewis",
       "url"=>"http://en.wikipedia.org/wiki/Lewis_Hamilton",
       "code"=>"HAM",
       "permanentNumber"=>"44",
       "driverId"=>"hamilton"
      },
     "wins"=>"1",
     "points"=>"25",
     "positionText"=>"1",
     "position"=>"1"
    }
  end

  it "provides attributes" do
    expect(StandingMapper.new(data)).to provide_attributes(
      driver_name: "Lewis Hamilton",
      position: 1,
      points: 25
    )
  end
end
