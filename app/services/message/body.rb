module Message
  class Body < String

    attr_reader :type

    REMINDER = {
      key: 'R',
      class: Reminder,
      regex: /\bremind me (to|that|about)\b/i
    }.freeze
    TYPES = {:reminder => REMINDER}.freeze

    def initialize(string, type=nil)
      @type = TYPES[type] if type
      super(string)
    end

    def type
      @type ||= get_type
    end

    def get_type
      raise "Not Yet Implemented"
      # should probably just do matching for the TYPES regexes
    end

    def phrases
      binding.pry
      # TODO:
      # builds an array of all of the phrases
      # something like [greeting, command_phrase, content_phrase, time_phrase]
      # time phrase will have further subcategories: every_phrase, at_phrase,
      # on_phrase, in_phrase
      phrase_arr = []
      phrase_arr << greeting if greeting.present?
      phrase_arr << command_phrase if command_phrase.present?
      phrase_arr << sanitized_body_phrase if sanitized_body_phrase.present?
    end

    def greeting
      regex = /\b#{ENV['SLACK_RUBY_BOT_ALIASES']}\b/
      match(regex) ? match(regex)[0] : ''
    end

    def command_phrase
      # TODO: add logic for other types here
      reminder_command_phrase
    end

    def reminder_command_phrase
      regex = REMINDER[:regex]
      match(regex) ? match(regex)[0] : ''
    end

    def time_phrase
      # TODO: implement the whole shabang
      # binding.pry
      TimePhraseParser.new(without(:greeting, :command_phrase)).parse
    end

    def sanitized_body_phrase
      without_array = []
      without_array << :greeting if greeting
      without_array << :command_phrase if command_phrase
      without_array << :time_phrase if time_phrase
      without(*without_array)
    end

    # private

    def without(*args)
      string = self.dup
      args.each do |method|
        string.gsub!(string.send(method), '')
      end
      string.clean
    end

    def clean
      str = self.dup # removes double spaces and leading and trailing spaces
      while str.include?('  ') do
        str.gsub!('  ', ' ')
      end
      str.strip
    end
    # def without_greeting
    #   @without_greeting ||= gsub(/\b#{ENV['SLACK_RUBY_BOT_ALIASES']}\b/, '').strip
    # end

    # def without_body
    #   binding.pry
    #   @without_body ||= gsub(type[:regex], '').strip
    # end

  end
end
