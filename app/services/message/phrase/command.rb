module Message
  module Phrase
    class Command < String

      REMINDER = /\bremind me (to|about|that)\b/i

      def initialize(string)
        regex = REMINDER
        super(string.match(regex) ? string.match(regex)[0] : '')
      end

    end
  end
end
