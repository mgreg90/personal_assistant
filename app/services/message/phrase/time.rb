module Message
  module Phrase
    class Time < String

      attr_reader :occurrences, :message

      def initialize(string)
        @string = string
        @parsed = Nickel.parse(string)
        @occurrences = @parsed.occurrences
        @time_string = get_time_string
        @message = get_message

        super(string.sub(message, '').strip)
      end

      private

      def get_time_string
        cleaned_string = @string.sub(/[,'"]/, '')
        cleaned_string.sub(@parsed.message, '').strip
      end

      def get_message
        @string.sub(@time_string, '').strip
      end

    end
  end
end
