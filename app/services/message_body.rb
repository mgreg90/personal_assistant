class MessageBody < String

  attr_reader :body

  BOT_NAMES = ENV['SLACK_RUBY_BOT_ALIASES'].split(',').map { |bn| /#{bn}/i }.freeze
  BOT_NAMES_REGEX = /(#{BOT_NAMES.join('|')})/i.freeze

  GREETING_REGEX = /.*(#{BOT_NAMES.join('|')})(\s|,)/i.freeze

  REMINDER_TEXT_REGEX = SlackMessage::MESSAGE_TYPE_MAP['r'][:regex].freeze

  def greeting_match
    @greeting_match ||= match GREETING_REGEX
  end

  def greeting
    @greeting ||= (greeting_match ? greeting_match[0] : '')
  end

  def reminder_text_match
    @reminder_text_match ||= match REMINDER_TEXT_REGEX
  end

  def reminder
    @reminder ||= (reminder_text_match ? reminder_text_match[0] : '')
  end

  def without(*parts)
    text = self.dup
    parts.each do |part|
      text.gsub!(regexify(part), '')
    end
    text.chomp
  end

  def stripped()
    without(:greeting, :reminder).strip
  end

  private

  def regexify(string)
    return string if string.is_a?(Regexp)
    /(\b*)#{ string.is_a?(Symbol) ? send(string) : string }(\b*)/i
  end

  def self.regexify(string)
    return string if string.is_a?(Regexp)
    /(\b*)#{ string.is_a?(Symbol) ? send(string) : string }(\b*)/i
  end

end
