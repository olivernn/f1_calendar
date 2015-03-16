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

    let(:mapped) { RaceMapper.new(data).to_h }

    it "has a name" do
      expect(mapped[:name]).to eq("My Race")
    end

    it "has a id" do
      expect(mapped[:id]).to eq("2015/1")
    end

    it "has a number" do
      expect(mapped[:number]).to eq(1)
    end

    it "has a starts_at" do
      datetime = DateTime.new(2015, 3, 15, 5, 0, 0).utc
      expect(mapped[:starts_at]).to eq(datetime)
    end

    it "has a season" do
      expect(mapped[:season]).to eq("2015")
    end

    it "has a url" do
      expect(mapped[:url]).to eq(URI("http://example.com"))
    end
  end
end
