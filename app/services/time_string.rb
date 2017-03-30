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
      regex: /\b(day(s?))\b/i,
      frequency_code: 'D'
    },
    weeks: {
      regex: /\b(week(s?))|(wk(s?))\b/i,
      frequency_code: 'W'
    },
    months: {
      regex: /\b(month(s?))|(mt(s?))\b/i,
      frequency_code: 'M'
    },
    years: {
      regex: /\b(year(s?))|(yr(s?))\b/i,
      frequency_code: 'Y'
    }
  }.freeze

  UNIQ_UNITS = {
    noon:     {
      recurring: false,
      unit: 'noon',
      value: {sec: 0, min: 0, hour: 12},
      regex: /(\b(noon)\b){1}/i
    },
    everyday: {
      recurring: true,
      unit: 'everyday',
      value: {bin_day: Date::EVERYDAY_BIN_DAY, interval: 1},
      regex: MessageToReminder::EVERYDAY
    }
  }.freeze

  UNIQ_WDAYS = [
    {values: ['weekday'], bin_week_day: '0111110'}
  ]

  UNITS = SHORT_TERM_UNITS.merge(LONG_TERM_UNITS).merge(UNIQ_UNITS).freeze

  TIME_REGEX_STRING = "([0-1]?[0-9]|2[0-3]):[0-5][0-9]".freeze
  TIME_VALUES = /\b#{TIME_REGEX_STRING}|(\d){1,3}\b/i.freeze

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

  def time_value?
    !!match(TIME_VALUES)
  end

  def values
    return [uniq_value] if uniq?
    case count(':')
    when 0
      time_value? ? [match(TIME_VALUES)[0].to_i] : []
    when 1
      match(TIME_VALUES)[0].split(':').map(&:to_i)
    end
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

  def bin_day_from_wday(opts)
    return uniq_bin_wday if uniq_bin_wday
    @bin_day_from_wday ||= begin

      bin_day = Date::DAYNAMES.map do |dn|
        (match_weekdays.include?(dn) ? '1' : '0')
      end.join
      bin_day = BinDay.new(bin_day)

      @is_bin_day = !bin_day.blank?

      return bin_day if bin_day_from_wday?
      return opts[:default] if opts[:default]
      Date::EMPTY_BIN_DAY
    end
  end

  def bin_day_from_wday?
    @is_bin_day
  end

  def match_weekdays
    @match_weekdays ||=
      split.map{|w| Date.wday_regex.match(w).to_a}
      .flatten
      .compact
      .uniq
      .select {|w| w.length > 2}
      .map{|w| w.singularize.capitalize}
  end

end
