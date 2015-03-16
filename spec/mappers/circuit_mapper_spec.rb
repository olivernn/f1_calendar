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

  it "provides mapped attributes" do
    expect(CircuitMapper.new(data)).to provide_attributes(
      name: "Yas Marina",
      url: URI("http://example.com"),
      lat: 24.4672,
      lng: 54.6301,
      country: "UAE",
      locality: "Abu Dhabi"
    )
  end
end
