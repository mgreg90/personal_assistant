module Message
  module Phrase
    class Collection < Array

      attr_reader :message, :greeting, :command

      def initialize(message, options={})
        @message = message
        @timezone = options[:timezone] # if message.respond_to?(:timezone)
        super([greeting, command, body, time])
      end

      def greeting
        @greeting ||= Greeting.new(message)
      end

      def command
        @command ||= begin
          cleaned_message = message.sub(greeting, '').strip
          Command.new(cleaned_message)
        end
      end

      def time
        @time ||= begin
          cleaned_message = message.sub(greeting , '').sub(command, '').strip
          if @timezone
            Phrase::Time.new(cleaned_message, timezone: @timezone)
          else
            Phrase::Time.new(cleaned_message)
          end
        end
      end

      def body
        @body ||= Phrase::Body.new(time.message)
      end

    end
  end
end
