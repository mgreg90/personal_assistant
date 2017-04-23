module Message
  module Phrase
    class Greeting < String

      def initialize(string)
        regex = /\b#{ENV['SLACK_RUBY_BOT_ALIASES']}\b/i
        super(string.match(regex) ? string.match(regex)[0] : '')
      end

    end
  end
end
