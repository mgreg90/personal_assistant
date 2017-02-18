class MsgTime

  class InvalidMsgTime < StandardError; end
  class IncompleteMsgTime < StandardError; end

  MERIDIAN_MAP = {am: /a(.?)m(.?)/i, pm: /p(.?)m(.?)/i}.freeze
  INSERTABLE_MERIDIAN_REGEXS = MERIDIAN_MAP.values.map(&:insertable)
  NUMERICAL_HOURS = (1..12).map{ |nh| nh.to_s.length == 2 ? nh.to_s : [nh.to_s, "0#{nh}"]}
  TEXT_HOURS = (1..12).map(&:humanize)
  VALID_HOURS = NUMERICAL_HOURS.reverse.push(*TEXT_HOURS).flatten.freeze
  MINUTE_REGEX = /\d:\d{2}/.freeze
  VALID_MINUTES = (0..60).map{|vm| vm.to_s.length == 2 ? vm.to_s : [vm.to_s, "0#{vm}"]}.flatten.freeze
  TIME_UNITS = {
    seconds: {limit: (365*24*60*60), regex: /sec(ond)?(s)?/i},
    minutes: {limit: (365*24*60), regex: /min(ute)?(s)?/i},
    hours: {limit: (365*24), regex: /(hr(s)?|(hour)(s)?)/i}
  }
  TIME_INDICATOR_REGEXS = {
    absolute: /(at|@)\s(#{VALID_HOURS.join('|')})(:(#{VALID_MINUTES.join('|')}){2})?(\s?)(#{MsgTime::INSERTABLE_MERIDIAN_REGEXS.join('|')})?/i.freeze,
    relative: /in\s((\d)+|an|a)\s(sec(ond)?(s)?|min(ute)?(s)?|hr(s)?|hour(s)?)/i
  }.freeze

  attr_reader :created_at, :text

  def initialize(string)
    @created_at = Time.now
    @text = stringify(string)
  end

  def to_s
    text
  end

  def stringify(string)
    TIME_INDICATOR_REGEXS.map do |_, tir|
      string.match(tir) if string.match(tir)
    end.compact.first[0]
  end

  def printable
    @printable ||= "#{sprintf('%02d', hour)}:#{sprintf('%02d', minute)} #{meridian.upcase}"
  end

  def type
    @type ||= TIME_INDICATOR_REGEXS.map do |k, tir|
       k if text.match(tir)
     end.compact.first
  end

  def meridian
    @meridian ||= send("meridian_#{type}")
  end

  def hour
    @hour ||= send("hour_#{type}")
  end

  def minute
    @minute ||= send("minute_#{type}")
  end

  def unit
    @unit ||= TIME_UNITS.map do |k, v|
      k if v[:regex].match(absolute)
    end.compact.first
  end

  def relative
    @relative ||= created_at + quantity.send("#{unit}")
  end

  private

  def quantity_matches
    @quantity_matches ||= (1..365).to_a.reverse.map do |num|
      arr = [text.match(/#{num}/), text.match(/#{num.humanize}/i)]
      arr << text.match(/a(n)?/i) if num == 1
      [num, arr.compact[0]]
    end.to_h.compact
  end

  def quantity
    @quantity ||= quantity_matches.keys.first
  end

  def absolute
    @absolute ||= text.gsub(/in(\s)/i, '')
  end

  def meridian_matches
    @meridian_matches ||= begin
      MERIDIAN_MAP.map do |m, regex|
        {m => regex} if text.match(regex)
      end.compact
    end
  end

  def meridian_absolute
    if meridian_matches.length > 1
      raise InvalidMsgTime, "More than one meridian"
    elsif meridian_matches.length == 0
      raise IncompleteMsgTime, "Missing meridian"
    end
    meridian_matches.first.keys.first.to_s.upcase
  end

  def meridian_relative
    time_relative.strftime("%P")
  end

  def hour_match
    @hour_match ||= text.match(/(#{VALID_HOURS.join('|')})/i)
  end

  def hour_absolute
    hour_match[0].to_i
  end

  def hour_relative
    time_relative.hour
  end

  def minute_match
    @minute_match ||= text.match(MINUTE_REGEX)
  end

  def minute_absolute
    (minute_match && minute_match[0].chomp[-2..-1].to_i) || 0
  end

  def minute_relative
    time_relative.min
  end

end
