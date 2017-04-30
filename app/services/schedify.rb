class Schedify

  attr_reader :occurrences, :message, :timezone, :nickel

  def self.parse(message, current_time=Time.zone.now)
    new(message, current_time)
  end

  def initialize(message, current_time)
    @timezone = current_time.zone || Time.zone.name
    @nickel = Nickel.parse(message, current_time)
    @message = @nickel.message
    @occurrences = @nickel.occurrences.map { |occ| to_schedule_hash(occ)}
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

end
