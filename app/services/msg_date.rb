class MsgDate

  RECURRING_DATE_INDICATORS = ['every'].push(*(Date::DAYNAMES.dup.map{|d| d + 's'}))
  RECURRING_DATE_REGEX = /(#{RECURRING_DATE_INDICATORS.join('|')})(\s?)/i.freeze
  STATIC_DATE_INDICATORS = Date::DAYNAMES.dup.push('today', 'tomorrow', *(Date::MONTHNAMES.dup.compact.push(*Date::ABBR_MONTHNAMES.compact).map{|m| "on #{m}"}))
  DATE_INDICATORS = RECURRING_DATE_INDICATORS.push(*STATIC_DATE_INDICATORS)

  attr_reader :text, :time

  def initialize(string, string_or_rel_time_obj=nil)
    @time = string_or_rel_time_obj if string_or_rel_time_obj.is_a?(MsgTime)
    @text = date_trim(string)
  end

  def date_trim(string)
    extra_text = Regexp.from_string(DATE_INDICATORS.join('|').prepend('(').concat(')'))
    extra_text = extra_text.match(string)
    return "#{time} #{to_date}" if extra_text.nil?
    extra_text = extra_text.pre_match
    string[extra_text.length..-1].strip
  end

  def recurring?
    @is_recurring ||= !!text.match(RECURRING_DATE_REGEX)
  end

  def to_s
    text
  end

  def to_date
    @to_date ||= if time
                   time.relative.to_date
                 else
                   Date.today
                 end
  end

  def weekday
    to_date.wday
  end

  def weekday_txt
    Date::DAYNAMES[weekday]
  end

end
