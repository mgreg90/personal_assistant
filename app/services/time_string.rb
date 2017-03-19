class TimeString < MessageBody

  SHORT_TERM_UNITS = {
    seconds: {
      regex: /\bsec(ond)?(s?)\b/i
    },
    minutes: {
      regex: /\bmin(ute)?(s?)\b/i
    },
    hours: {
      regex: /\b(hour(s?))|(hr(s)?)\b/i
    }
  }.freeze

  LONG_TERM_UNITS = {
    days: {
      regex: /\b(day(s?))\b/i
    },
    weeks: {
      regex: /\b(week(s?))|(wk(s?))\b/i
    },
    months: {
      regex: /\b(month(s?))|(mt(s?))\b/i
    },
    years: {
      regex: /\b(year(s?))|(yr(s?))\b/i
    }
  }.freeze

  UNITS = SHORT_TERM_UNITS.merge(LONG_TERM_UNITS).freeze

  TIME_VALUES = /\b(\d){1,3}\b/i.freeze

  MERIDIANS = {
    am: /\b(a(\.)?m(\.|\b))/i,
    pm: /\b(p(\.)?m(\.|\b))/i
  }.freeze

  def unit
    UNITS.each do |key, stu_hash|
      return key if match(stu_hash[:regex])
    end
    nil
  end

  def value
    match(TIME_VALUES)[0].to_i
  end

  def meridian
    MERIDIANS.each do |key, regex|
      return key if match(regex)
    end
  end

end
