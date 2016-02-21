class FeedsController < ApplicationController
  def show
    respond_to do |format|
      format.ical { render text: feed.to_ical }
    end
  end

  private

  def feed
    FeedPresenter.new(races)
  end

  def races
    Race.all(season: Time.now.year)
  end

end
