class MsgDate < String

  RECURRING_DATE_INDICATORS = ['every'].push(*(Date::DAYNAMES.dup.map{|d| d + 's'}))
  RECURRING_DATE_REGEX = /(#{RECURRING_DATE_INDICATORS.join('|')})(\s?)/i.freeze
  STATIC_DATE_INDICATORS = Date::DAYNAMES.dup.push('today', 'tomorrow', *(Date::MONTHNAMES.dup.compact.push(*Date::ABBR_MONTHNAMES.compact).map{|m| "on #{m}"}))
  DATE_INDICATORS = RECURRING_DATE_INDICATORS.push(*STATIC_DATE_INDICATORS)

  def initialize(string)
    super(date_trim(string))
  end

  def date_trim(string)
    extra_text = Regexp.from_string(DATE_INDICATORS.join('|').prepend('(').concat(')')).match(string).pre_match
    string[extra_text.length..-1].strip
  end

  def recurring?
    @is_recurring ||= !!match(RECURRING_DATE_REGEX)
  end

end
