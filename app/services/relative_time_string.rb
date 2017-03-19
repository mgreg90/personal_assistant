class RelativeTimeString < TimeString

  include MessageToReminder

  def initialize(string)
    super(string)
  end

  def time
    Time.now + value.send(:"#{unit}")
  end

end
