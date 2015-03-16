describe ResultMapper do
  let(:data) do
    {
      "number"=>"44",
      "position"=>"1",
      "Driver"=>{
        "driverId"=>"hamilton",
        "permanentNumber"=>"44",
        "code"=>"HAM",
        "url"=>"http://en.wikipedia.org/wiki/Lewis_Hamilton",
        "givenName"=>"Lewis",
        "familyName"=>"Hamilton",
        "dateOfBirth"=>"1985-01-07",
        "nationality"=>"British"
      },
      "Constructor"=>{
        "constructorId"=>"mercedes",
        "url"=>"http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One",
        "name"=>"Mercedes",
        "nationality"=>"German"
      },
      "Q1"=>"1:28.586",
      "Q2"=>"1:26.894",
      "Q3"=>"1:26.327"
    }
  end

  it "provides attributes" do
    expect(GridPositionMapper.new(data)).to provide_attributes(
      driver_name: "Lewis Hamilton",
      position: 1
    )
  end
end
