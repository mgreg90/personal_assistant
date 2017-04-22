module Message
  class AtPhrase < PrepositionalPhrase

    MERIDIAN_FORMATS = [
      {
        regex: /^a\.?m\.?$/i,
        value: 0,
        value12: -12 # if 12 am, hour should be 0
      }, {
        regex: /^p\.?m\.?$/i,
        value: 12,
        value12: 0 # if 12 pm, hour should be 12
      }
    ]

    HR_MIN_FORMATS = [
      {
        regex: /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/,
        type: 'HR:MIN',
      }, {
        regex: /^([0-9]|0[0-9]|1[0-9]|2[0-3])$/,
        type: 'HR'
      }
    ].freeze

    def initialize(phrase)
      super(phrase)
      @time = time
    end

    def words_arr
      @words_arr ||= sub('at ', '').split
    end

    def valid_time?
      !!(hr_min_format && meridian_format)
    end

    def hr_min_format
      HR_MIN_FORMATS.each do |hrm|
        return hrm if hrm[:regex].match(words_arr.first)
      end
      nil
    end

    def meridian_format
      MERIDIAN_FORMATS.each do |mf|
        return mf if mf[:regex].match(words_arr.second)
      end
      nil
    end

    def meridian_hours
      if extracted_hour == 12
        meridian_format[:value12]
      else
        meridian_format[:value]
      end
    end

    def time?
      !!time
    end

    def time
      return nil if !valid_time?
      time_obj
    end

    def meridian?
      !!meridian_format
    end

    def extracted_hour
      case hr_min_format[:type]
      when 'HR:MIN'
        words_arr.first.split(':').first.to_i
      when 'HR'
        words_arr.first.to_i
      else
        0
      end
    end

    def hour
      extracted_hour + meridian_hours
    end

    def minute
      case hr_min_format[:type]
      when 'HR:MIN'
        words_arr.first.split(':').second.to_i
      else
        0
      end
    end

    def time_obj
      {
        hour: hour,
        minute: minute
      }
    end

  end
end
