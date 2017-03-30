module MessageToReminder

  LAST_EVERY = /(\b)every/i.freeze
  LAST_IN = /(\b)in(\b)/i.freeze
  LAST_AT = /(\b)at(\b)/i.freeze
  LAST_ON = /(\b)on(\b)/i.freeze
  EVERYDAY = /(\b)everyday(\b)/i.freeze
  RECURRING_VALUE_UNIT = /(\b)every(\s)(\d*)(\s)days(\b)/i.freeze

  def reminder_hash
    @reminder_hash ||= begin
      if last_every
        if everyday?
          # case 10
          everyday_reminder_hash
        else
          if recurring_value_unit?
            # case 6
            recurring_value_unit_reminder_hash
            # case 7
            # case 8
            # case 9
            # case 4
          else
            recurring_wday_reminder_hash
          end
        end
      else
        if last_in?
          if last_at?
            # case 2
            relative_to_absolute_reminder_hash
          else
            # case 1
            relative_reminder_hash
          end

        else
          # case 3
          absolute_reminder_hash
        end
      end
    end
  end

  def message
    TimeString.new(body).stripped
  end

  def last_every?
    !!message.match(LAST_EVERY)
  end

  def last_every
    @last_every ||=
      if last_every?
        message[message.rindex(LAST_EVERY)..-1]
      end
  end

  def last_in?
    !!message.match(LAST_IN)
  end

  def last_in(**options)
    @last_in ||=
      if last_in?
        rts = RelativeTimeString.new(message[message.rindex(LAST_IN)..-1])
        options[:clean] ? rts.gsub(last_at, '') : rts
      end
  end

  def last_at?
    !!message.match(LAST_AT)
  end

  def last_at
    @last_at ||= if last_at?
      la = message[message.rindex(LAST_AT)..-1]
      la = la.gsub(last_on, '').strip if last_on
      la
    end
  end

  def last_on
    @last_on ||= if last_on?
      lo = message[message.rindex(LAST_ON)..-1]
      # lo = lo.gsub(last_at, '').strip if last_at # causes infinite loop
      lo
    end
  end

  def last_on?
    !!message.match(LAST_ON)
  end

  def relative_time_string
    last_in(clean: last_at?)
  end

  def absolute_time_string
    @absolute_time_string = AbsoluteTimeString.new(last_at) rescue nil
  end

  def everyday?
    @everyday ||= !!everyday_match
  end

  def everyday_match
    last_every.match(EVERYDAY) if last_every
  end

  def recurring_time_string
    if everyday?
      RecurringTimeString.new(everyday_match[0])
    elsif last_at? && last_every
      RecurringTimeString.new(last_every.gsub(last_at, '').strip)
    end
  end

  def recurring_value_unit?
    !!recurring_value_match
  end

  def recurring_value_match
    @recurring_value_match ||= begin
      rec_match = message.match(RECURRING_VALUE_UNIT)
      rec_match[0] if rec_match
    end
  end

  def default_message
    args = []
    args << relative_time_string if relative_time_string
    args << absolute_time_string if absolute_time_string
    args << recurring_time_string if recurring_time_string
    message.without(*args).response_replace.strip.capitalize
  end

  def default_reminder_hash
    {
      message: default_message,
      status: Reminder::ACTIVE_STATUS
    }
  end

  def everyday_reminder_hash
    {
      recurrences_attributes: [{
        bin_week_day: '1111111',
        frequency_code: Reminder::WEEKLY_FREQUENCY,
        interval: recurring_time_string.interval,
        time: absolute_time_string.to_hash
      }]
    }.merge(default_reminder_hash)
  end

  def recurring_wday_reminder_hash
    # byebug if body == "remind me that I have to exercise every 26 weeks at 8 a.m."
    {
      recurrences_attributes: [{
        bin_week_day: recurring_time_string.bin_day_from_wday(default: Date.today.bin_day), # needs a method
        frequency_code: Reminder::WEEKLY_FREQUENCY,
        interval: recurring_time_string.interval,
        time: absolute_time_string.to_hash
      }]
    }.merge(default_reminder_hash)
  end

  def recurring_value_unit_reminder_hash
    {
      recurrences_attributes: [{
        interval: recurring_time_string.values.first,
        frequency_code: TimeString::UNITS[recurring_time_string.unit][:frequency_code],
        time: absolute_time_string.to_hash
      }]
    }.merge(default_reminder_hash)
  end

  def relative_reminder_hash
    {
      occurrence: relative_time_string.time
    }.merge(default_reminder_hash)
  end

  def relative_to_absolute_reminder_hash
    {
      occurrence: relative_time_string.time.change(absolute_time_string.to_hash)
    }.merge(default_reminder_hash)
  end

  def absolute_reminder_hash
    {
      occurrence: Time.now.change(absolute_time_string.to_hash)
    }.merge(default_reminder_hash)
  end

end
