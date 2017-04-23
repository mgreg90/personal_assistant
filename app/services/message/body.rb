module Message
  class Body < String

    attr_reader :phrases

    def initialize(string, options={})
      @timezone = options[:timezone]
      super(string)
    end

    def phrases
      @phrases ||= Phrase::Collection.new(to_s, timezone: @timezone)
    end

    def greeting_phrase
      phrases.find { |phrase| phrase.class == Message::Phrase::Greeting }
    end

    def command_phrase
      phrases.find { |phrase| phrase.class == Message::Phrase::Command }
    end

    def body_phrase
      phrases.find { |phrase| phrase.class == Message::Phrase::Time }
    end

    def time_phrase
      phrases.find { |phrase| phrase.class == Message::Phrase::Time }
    end

  end
end
