RSpec::Matchers.define :include_event do |uid|
  match do |obj|
    calendar = Icalendar.parse(obj.to_ical).first
    event = calendar.find_event(uid)
    event.summary == @summary &&
      event.dtstart == @starting_at &&
      event.dtend == @ending_at
  end

  chain :with_summary do |summary|
    @summary = summary
  end

  chain :starting_at do |starting_at|
    @starting_at = starting_at
  end

  chain :ending_at do |ending_at|
    @ending_at = ending_at
  end
end
