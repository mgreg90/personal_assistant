class AbsoluteTimeString < TimeString

  def initialize(string)
    super(string)
  end

  def time_hash
    th = {}
    # th[:sec] = value if unit == :second
    # th[:min] = value if unit == :minute
    th[:hour] = hour if hour
    th
  end

  def hour
    if meridian == :pm
      value + 12
    else
      value
    end
  end

end
