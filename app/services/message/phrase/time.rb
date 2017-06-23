module Message
  module Phrase
    class Time < String

      attr_reader :occurrences, :message, :timezone

      def initialize(body, options={})
        @body = body
        @timezone = options[:timezone] || ::Time.zone
        @parsed = Schedify.parse(body, ::Time.now.in_time_zone(timezone))
        @occurrences = @parsed.occurrences
        @time_str = @parsed.time_str
        @message = @parsed.message

        super(body.sub(message, '').strip)
      end

      def to_schedules
        @parsed.occurrences
      end

      private

    end
  end
end
