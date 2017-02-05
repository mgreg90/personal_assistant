class MsgTime < String

  class InvalidMsgTime < StandardError; end
  class IncompleteMsgTime < StandardError; end

  MERIDIAN_MAP = {am: /a(.?)m(.?)/i, pm: /p(.?)m(.?)/i}.freeze
  INSERTABLE_MERIDIAN_REGEXS = MERIDIAN_MAP.values.map(&:insertable)
  NUMERICAL_HOURS = (1..12).to_a
  TEXT_HOURS = (1..12).map(&:humanize)
  VALID_HOURS = NUMERICAL_HOURS.reverse.push(*TEXT_HOURS).flatten.freeze
  MINUTE_REGEX = /\d:\d{2}/.freeze
  VALID_MINUTES = (0..60).to_a
  TIME_INDICATOR_REGEX = /(at|@)\s(#{VALID_HOURS.join('|')})(:(#{VALID_MINUTES.join('|')}){2})?(\s?)(#{MsgTime::INSERTABLE_MERIDIAN_REGEXS.join('|')})?/i.freeze

  def initialize(string)
    super(string.match(TIME_INDICATOR_REGEX)[0])
  end

  def meridian_matches
    @meridian_matches ||= begin
      a = MERIDIAN_MAP.map do |m, regex|
        {m => regex} if match(regex)
      end.compact
    end
  end

  def meridian
    @meridian ||= begin
      if meridian_matches.length > 1
        raise InvalidMsgTime, "More than one meridian"
      elsif meridian_matches.length == 0
        raise IncompleteMsgTime, "Missing meridian"
      end
      meridian_matches.first.keys.first.to_s.upcase
    end
  end

  def hour_match
    @hour_match ||= match(/(#{VALID_HOURS.reverse.join('|')})/i)
  end

  def hour
    @hour ||= hour_match[0].to_i
  end

  def minute_match
    @minute_match ||= match(MINUTE_REGEX)
  end

  def minute
    @minute ||= minute_match[0].chomp[-2..-1].to_i || 0
  end

end
