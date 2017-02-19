class MsgBody < String

  attr_reader :body

  BOT_NAMES = ENV['SLACK_RUBY_BOT_ALIASES'].split(',').map { |bn| /#{bn}/i }.freeze
  BOT_NAMES_REGEX = /(#{BOT_NAMES.join('|')})/i
  GREETING_REGEX = /.*(#{BOT_NAMES.join('|')})(\s|,)/i

  def greeting_match
    @greeting_match ||= match GREETING_REGEX
  end

  def greeting
    @greeting ||= (greeting_match ? greeting_match[0] : "")
  end

  def without(*parts)
    text = self.dup
    parts.each do |part|
      text.gsub!(regexify(part), '')
    end
    text.chomp
  end

  def stripped(options={})
    args = [:greeting]
    args << options[:msg_date] if options[:msg_date].to_s.present?
    args << options[:msg_time] if options[:msg_time]
    args << options[:type_regex] if options[:type_regex]
    without(*args).chomp
  end

  private

  def regexify(string)
    return string if string.is_a?(Regexp)
    /(\s*)#{ string.is_a?(Symbol) ? send(string) : string }(\s*)/i
  end

end
