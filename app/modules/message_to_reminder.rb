module MessageToReminder

  LAST_EVERY = /(\b)every/i
  LAST_IN = /(\b)in(\b)/i
  LAST_AT = /(\b)at(\b)/i
  EVERYDAY = /(\b)everyday(\b)/i

  def reminder_hash
    @reminder_hash ||= begin
      if last_every
        if everyday?
          # case 10
          everyday_reminder_hash
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
    MessageBody.new(body).stripped
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

  def relative_time_string
    last_in(clean: !!last_at)
  end

  def last_at?
    !!message.match(LAST_AT)
  end

  def last_at
    @last_at ||= if last_at?
      message[message.rindex(LAST_AT)..-1]
    end
  end

  def absolute_time_string
    @absolute_time_string = AbsoluteTimeString.new(last_at) rescue nil
  end

  def everyday?
    @everyday ||= !!recurring_time_string
  end

  def recurring_time_string
    last_every.match(EVERYDAY)[0] rescue nil
  end

  def default_message
    args = []
    args << relative_time_string if relative_time_string
    args << absolute_time_string if absolute_time_string
    args << recurring_time_string if recurring_time_string
    message.without(*args).strip
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
        interval: 1
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
      occurrence: relative_time_string.time.change(absolute_time_string.time_hash)
    }.merge(default_reminder_hash)
  end

  def absolute_reminder_hash
    {
      occurrence: Time.now.change(absolute_time_string.time_hash)
    }.merge(default_reminder_hash)
  end

end
