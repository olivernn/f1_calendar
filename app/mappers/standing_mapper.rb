class StandingMapper < BaseMapper
  provides :driver_name, :position, :points

  private

  def driver_name
    "#{driver_first_name} #{driver_last_name}"
  end

  def driver_first_name
    driver.fetch("givenName")
  end

  def driver_last_name
    driver.fetch("familyName")
  end

  def driver
    data.fetch("Driver")
  end

  def position
    data.fetch("position").to_i
  end

  def points
    data.fetch("points").to_i
  end
end
