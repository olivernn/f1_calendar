require 'rails_helper'

describe RaceMapper do
  describe "#to_h" do
    let(:data) do
      {
        "season" => "2015",
        "round" => "1",
        "raceName" => "My Race",
        "date" => "2015-03-15",
        "time" => "05:00:00Z",
        "url" => "http://example.com",
        "Circuit" => {
          "url" => "http://example.com",
          "circuitName" => "Yas Marina",
          "Location" => {
            "country" => "UAE",
            "locality" => "Abu Dhabi",
            "long" => "54.6301",
            "lat" => "24.4672",
          },
        }
      }
    end

    it "provides mapped attributes" do
      expect(RaceMapper.new(data)).to provide_attributes(
        name: "My Race",
        id: "F1/2015/1",
        number: 1,
        starts_at: DateTime.new(2015, 3, 15, 5, 0, 0).utc,
        season: "2015",
        url: URI("http://example.com")
      )
    end
  end
end
