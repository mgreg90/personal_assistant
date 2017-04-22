module Message
  class PrepositionalPhrase < Body

    def initialize(phrase)
      super(phrase)
    end

    def time
      raise NotImplementedError
    end

  end
end
