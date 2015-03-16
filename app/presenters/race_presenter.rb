require 'icalendar'
require 'icalendar/tzinfo'
require 'icalendar/values/apple_structured_location'

class RacePresenter
  def self.to_proc
    proc { |race| new(race).ical_event }
  end

  def initialize(race)
    @race = race
  end

  def ical_event
    Icalendar::Event.new.tap do |event|
      event.dtstart = dtstart
      event.dtend = dtend
      event.uid = uid
      event.summary = summary
      event.x_apple_structured_location = location

      event.alarm do |a|
        a.summary = summary
        a.trigger = "-P1DT0H0M0S"
      end

      event.alarm do |a|
        a.summary = summary
        a.trigger = "-PT15M"
      end
    end
  end

  private

  attr_reader :race

  def dtstart
    Icalendar::Values::DateTime.new(race.starts_at, tzid: "UTC")
  end

  def dtend
    Icalendar::Values::DateTime.new(race.starts_at + 2.hours, tzid: "UTC")
  end

  def address
    [race.circuit.name, race.circuit.locality, race.circuit.country].join("\n")
  end

  def location
    Icalendar::Values::AppleStructuredLocation.new(
      address: [race.circuit.name, race.circuit.locality, race.circuit.country].join("\n"),
      title: race.circuit.name,
      lat: race.circuit.lat,
      lng: race.circuit.lng
    )
  end

  def uid
    race.id
  end

  def summary
    race.name
  end
end
