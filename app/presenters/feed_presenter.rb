require 'icalendar'

class FeedPresenter
  def initialize(races)
    @races = races
  end

  def to_ical
    races
      .map(&RacePresenter)
      .each_with_object(Icalendar::Calendar.new) { |event, calendar| calendar.add_event(event) }
      .to_ical
  end

  private

  attr_reader :races
end
