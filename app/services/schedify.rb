class Schedify

  attr_reader :timezone, :nickel, :body

  VALID_AT_TIME_PHRASE = /^at\s(?<hour>((1[012])|(0?\d)))(:(?<min>[6543210]\d))?(\s)?(?<meridian>(a.?m.?)|(p.?m.?))$/i

  def self.parse(body, current_time=Time.zone.now)
    new(body, current_time)
  end

  def initialize(body, current_time)
    @timezone = current_time.zone || Time.zone.name
    @body = body
    @nickel = nickel_parse(current_time)#Nickel.parse(body, current_time)
    self
  end

  def to_schedule_hash(occ)
    {
      schedule_type:  occ[:type],
      start_time:     occ[:start_time].present? ? occ[:start_time].to_time.in_time_zone : nil,
      end_time:       occ[:end_time].present? ? occ[:end_time].to_time.in_time_zone : nil,
      interval:       occ[:interval],
      day_of_week:    occ[:day_of_week],
      week_of_month:  occ[:week_of_month],
      date_of_month:  occ[:date_of_month],
      timezone:       @timezone,
    }
  end

  def occurrences
    @occurrences ||= @nickel.occurrences.map { |occ| to_schedule_hash(occ)}
  end

  def time_str
    @time_str || set_time_str(@nickel)
  end

  def message
    @message ||= body.sub(time_str, '').strip
  end

  def nickel_parse(current_time)
    parsed = Nickel.parse(body, current_time)
    # if there are no occurrences but nickel recognizes a time string
    # NOTE: so far that means "at 10 AM" needs a "today" or "tomorrow" or something
    if parsed.occurrences.empty? && set_time_str(parsed).present?
      # loop thru words
      # binding.pry
      if valid_time_string?
      # regex for valid clock times
        # Possible MissingAttributes
          # meridian
          # no hour => no numbers at all
      # if valid
        # convert to datetime
        # compare to now
        # if later today, put today
        # if in past, put tomorrow
      # else
        # raise NoTimeString error
      end
    end
    parsed
  end

  private

  def set_time_str(nickel)
    cleaned_string = body.sub(/[,'"]/, '')
    @time_str = cleaned_string.sub(nickel.message, '').strip
  end

  def missing_time_string_attributes
    ts_match = time_str.match(VALID_AT_TIME_PHRASE)

  end

  def valid_time_string?
    # build only for at_phrase so far
    ts_match = time_str.match(VALID_AT_TIME_PHRASE)
    return true if ts_match[:hour].present? && ts_match[:meridian].present?
    false
  end

end
