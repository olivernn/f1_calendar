require 'icalendar'

class FeedPresenter
  def initialize(races)
    @past_races, @future_races = races.partition(&:past?)
    @next_race = @future_races.delete_at(0)
  end

  def to_ical
    races
      .each_with_object(Icalendar::Calendar.new) { |event, calendar| calendar.add_event(event) }
      .to_ical
  end

  private

  attr_reader :past_races, :future_races, :next_race

  def races
    past_races + next_race + future_races
  end

  def past_races
    @past_races.map(&PastRacePresenter)
  end

  def future_races
    @future_races.map(&FutureRacePresenter)
  end

  def next_race
    Array(@next_race).map(&NextRacePresenter)
  end
end
