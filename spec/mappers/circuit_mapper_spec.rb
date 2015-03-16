require 'rails_helper'

describe CircuitMapper do
  let(:data) do
    {
      "url" => "http://example.com",
      "circuitName" => "Yas Marina",
      "Location" => {
        "country" => "UAE",
        "locality" => "Abu Dhabi",
        "long" => "54.6301",
        "lat" => "24.4672",
      },
    }
  end

  describe "#to_h" do
    let(:mapper) { CircuitMapper.new(data).to_h }

    it "provides a name" do
      expect(mapper[:name]).to eq("Yas Marina")
    end

    it "provides a url" do
      expect(mapper[:url]).to eq(URI("http://example.com"))
    end

    it "provides a lat coord" do
      expect(mapper[:lat]).to eq(24.4672)
    end

    it "provides a lng coord" do
      expect(mapper[:lng]).to eq(54.6301)
    end

    it "provides a country" do
      expect(mapper[:country]).to eq("UAE")
    end

    it "provides a locality" do
      expect(mapper[:locality]).to eq("Abu Dhabi")
    end
  end
end
