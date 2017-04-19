module Message
  class TimePhraseParser

    attr_reader :clause

    TIME_PHRASE_INDICATORS = ['at', 'every', 'in', 'on']

    def initialize(clause)
      @clause = clause
    end

    def parse
      phrases = []
      current_phrase = ''
      clause_arr.each do |word|
        if is_prep?(word)
          phrases << clean_phrase(current_phrase)
          current_phrase = ''
        end
        current_phrase << "#{word} "
      end
      phrases << clean_phrase(current_phrase)
      binding.pry
      phrases
    end

    def clause_arr
      clause.split
    end

    def is_prep?(word)
      LanguageUtils::PREPOSITIONS.any? { |prep| word.match(/^#{prep}$/i) }
    end

    def is_time_str?(word)
      TIME_PHRASE_INDICATORS.any? { |tpi| word.match(/^#{tpi}$/i) }
    end

    def clean_phrase(phrase)
      TIME_PHRASE_INDICATORS.each do |tpi|
        if phrase.strip.match(/^#{tpi}\s/i)
          binding.pry
          return "Message::#{tpi.capitalize}Phrase".constantize.new(phrase)
        end
      end
      phrase.strip
    end

  end
end
