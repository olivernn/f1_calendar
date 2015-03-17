require 'rails_helper'

describe FeedPresenter do
  describe "#to_ical" do

    before { Timecop.freeze(DateTime.new(2015, 3, 17, 12, 0, 0).utc) }
    after { Timecop.return }

    let(:races) { Race.all }
    let(:feed_presenter) { FeedPresenter.new(races) }
    let(:calendar) { feed_presenter.to_ical }

    it "includes an event for each race" do
      VCR.use_cassette("generating_feed") do
        expect(feed_presenter).to include_event("F1/2015/1")
          .with_summary("Australian Grand Prix")
          .starting_at(DateTime.new(2015, 3, 15, 5, 0, 0).utc)
          .ending_at(DateTime.new(2015, 3, 15, 7, 0, 0).utc)
      end
    end
  end
end
