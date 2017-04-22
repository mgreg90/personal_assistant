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
      clause_arr.each_with_index do |word, idx|
        if is_prep?(word)
          phrases << objectify_phrase(current_phrase)
          current_phrase = ''
        end
        last_item = (idx == (clause_arr.size - 1))
        word += ' ' unless last_item
        current_phrase << word
      end
      phrases << objectify_phrase(current_phrase)
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

    def objectify_phrase(phrase)
      TIME_PHRASE_INDICATORS.each do |tpi|
        if phrase.strip.match(/^#{tpi}\s/i)
          return "Message::#{tpi.capitalize}Phrase".constantize.new(phrase)
        end
      end
      phrase
    end

  end
end
