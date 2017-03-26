class AbsoluteTimeString < TimeString

  def initialize(string)
    super(string)
  end

  def to_hash
    return uniq_value.merge(timezone: timezone) if uniq?
    th = {}
    th[:sec] = second
    th[:min] = minute
    th[:hour] = hour if hour
    th.merge(timezone: timezone)
  end

  def hour
    case unit
    when :hours
      if meridian == :pm
        value + 12
      else
        value
      end
    when :minutes, :seconds
      false
    end
  end

  def minute
    case unit
    when :hours
      0
    when :minutes
      value
    when :seconds
      false
    end
  end

  def second
    case unit
    when :hours, :minutes
      0
    when :seconds
      value
    end
  end

  def unit
    super || begin
      :hours if meridian
    end
  end

  def timezone
    DEFAULT_TIMEZONE
  end

end