class Time

  def format_us
    strftime("%b %e %Y, %l:%M %p")
  end

  def self.next_noon
    (Time.now + 12.hours).change(hour: 12)
  end

  def next_noon
    (self + 12.hours).change(hour: 12)
  end

end
