module Message
  class OnPhrase < PrepositionalPhrase
    # ON PHRASES TO SUPPORT
    # 'on tuesdays'
    # 'on monday'
    # 'on May 3rd'
    # 'on the 10th'
    def initialize(phrase)
      super(phrase)
      @time = time
    end

    def words_arr
      @words_arr ||= sub('on ', '').split
    end

    def time
      # validation goes here
      time_obj
    end

    def time_obj
      {

      }
    end

  end
end
