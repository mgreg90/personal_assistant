module Message
  module Phrase
    class Time < String

      attr_reader :occurrences, :message, :timezone

      def initialize(string, options={})
        @string = string
        @timezone = options[:timezone] || ::Time.zone
        @parsed = Schedify.parse(string, ::Time.now.in_time_zone(timezone))
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
