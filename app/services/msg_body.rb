class MsgBody < String

  attr_reader :body

  BOT_NAMES = ENV['SLACK_RUBY_BOT_ALIASES'].split(',').map { |bn| /#{bn}/i }.freeze
  PLURAL_WEEKDAYS_REGEX = /(#{Date::DAYNAMES.join('|')})s(\s|)/i.freeze

  def recurring?
    @is_recurring ||= !!match(/(each|every)(\s|)/i) || !!match(PLURAL_WEEKDAYS_REGEX)
  end

  def greeting_matches
    @greeting_matches ||= BOT_NAMES.map do |bn|
      match bn
    end
  end

  def greeting
    @greeting ||= greeting_matches.first[0]
  end

  def without(*parts)
    text = self.dup
    parts.each do |part|
      text.gsub!(regexify(part), '')
    end
    text.chomp
  end

  private

  def regexify(string)
      /(\s*)#{ string.is_a?(Symbol) ? send(string) : string }(\s*)/i
  end

end
