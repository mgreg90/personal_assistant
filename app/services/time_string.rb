class TimeString < MessageBody

  class InvalidTimeString < StandardError; end

  DEFAULT_TIMEZONE = 'America/New_York'

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

  UNIQ_UNITS = {
    noon: { unit: 'noon', value: {sec: 0, min: 0, hour: 12}, regex: /(\b(noon)\b){1}/i }
  }.freeze

  UNIQ_WDAYS = [
    {values: ['weekday'], bin_week_day: '0111110'}
  ]

  UNITS = SHORT_TERM_UNITS.merge(LONG_TERM_UNITS).merge(UNIQ_UNITS).freeze

  TIME_VALUES = /\b(\d){1,3}\b/i.freeze

  MERIDIANS = {
    am: /\b(a(\.)?m(\.|\b))/i,
    pm: /\b(p(\.)?m(\.|\b))/i
  }.freeze

  def uniq?
    !!uniq_value
  end

  def uniq_value
    @uniq_value ||= begin
      uniq_hash = UNIQ_UNITS.values.find { |uh| match(uh[:regex]) }
      uniq_hash[:value] if uniq_hash
    end

  end

  def unit
    UNITS.each do |key, unit_hash|
      return key if match(unit_hash[:regex])
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
    false
  end

  def uniq_bin_wday
    @uniq_bin_wday ||= begin
      UNIQ_WDAYS.each do |wd|
        wd[:values].each do |matcher|
          if match(/\b#{matcher}\b/i)
            return wd[:bin_week_day]
          end
        end
      end
      false
    end
  end

  def bin_day_from_wday
    return uniq_bin_wday if uniq_bin_wday
    Date::DAYNAMES.map do |dn|
      (match_weekdays.include?(dn) ? '1' : '0')
    end.join
  end

  def match_weekdays
    split.map{|w| Date.wday_regex.match(w).to_a}
    .flatten
    .compact
    .uniq
    .select {|w| w.length > 2}
    .map{|w| w.singularize.capitalize}
  end

end
