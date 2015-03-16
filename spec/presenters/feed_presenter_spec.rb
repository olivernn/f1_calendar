require 'rails_helper'

describe FeedPresenter do
  describe "#to_ical" do
    let(:circuit) do
      Circuit.new(
        name: "MyCircuit",
        url: URI("http://example.com"),
        lat: 1.23,
        lng: 4.56,
        country: "UK",
        locality: "london"
      )
    end

    let(:race) do
      Race.new(
        id: "2015/1",
        name: "First Race",
        number: 1,
        season: "2015",
        starts_at: DateTime.new(2015, 3, 15, 5, 0, 0).utc,
        url: URI("http://example.com"),
        circuit: circuit
      )
    end

    let(:feed_presenter) { FeedPresenter.new([race]) }
    let(:calendar) { feed_presenter.to_ical }

    it "includes an event for each race" do
      expect(feed_presenter).to include_event("2015/1")
        .with_summary("First Race")
        .starting_at(DateTime.new(2015, 3, 15, 5, 0, 0).utc)
        .ending_at(DateTime.new(2015, 3, 15, 7, 0, 0).utc)
    end
  end
end
