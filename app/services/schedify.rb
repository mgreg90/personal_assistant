class Schedify

  attr_reader :occurrences, :message, :timezone, :nickel

  def self.parse(string, current_time=Time.zone.now)
    new(string, current_time)
  end

  def initialize(string, current_time)
    @timezone = current_time.zone || Time.zone.name
    @nickel = Nickel.parse(string, current_time)
    @message = @nickel.message
    @occurrences = @nickel.occurrences.map { |occ| clean_occurrence(occ)}
    self
  end

  def clean_occurrence(occ)
    {
      type:           occ[:type],
      start_time:     occ[:start_time].present? ? occ[:start_time].to_time.in_time_zone : nil,
      end_time:       occ[:end_time].present? ? occ[:end_time].to_time.in_time_zone : nil,
      interval:       occ[:interval],
      day_of_week:    occ[:day_of_week],
      date_of_month:  occ[:date_of_month],
      timezone:       @timezone,
    }
  end

end
