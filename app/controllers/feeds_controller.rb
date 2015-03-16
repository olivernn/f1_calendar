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
    Race.all
  end

  def text_calendar
    Mime::Type["text/calendar"]
  end
end
