module Message
  class PrepositionalPhrase < String

    def initialize(phrase)
      super(phrase)
    end

    def time
      raise NotImplementedError
    end

  end
end
