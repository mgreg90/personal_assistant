class Schedule < ApplicationRecord

  SINGLE_TYPE = 'single'.freeze

  ################################################
  # ATTRIBUTES:
  # t.datetime        :next_occurrence
  # t.datetime        :last_occurrence
  # t.string          :schedule_type
  # t.datetime        :start_time
  # t.datetime        :end_time
  # t.string          :interval
  # t.integer         :day_of_week
  # t.string          :week_of_month
  # t.string          :date_of_month
  # t.string          :timezone
  # t.references      :reminder, foreign_key: true
  ################################################

  belongs_to :reminder, optional: true

  before_save :set_next_and_last_occurrences
  # before_save :set_job

  def find_next_occurrence(tz=Time.zone.name)
    case schedule_type
    when SINGLE_TYPE
      start_time.in_time_zone(tz)
    else
      # TODO expand for different types
      raise NotImplemented, "This schedule type isn't handled yet!"
    end
  end

  def set_next_and_last_occurrences(ref_date=Time.zone.now)
    if next_occurrence.blank?
      self.next_occurrence = find_next_occurrence
    elsif next_occurrence <= ref_date
      self.last_occurrence = next_occurrence
      self.next_occurrence = find_next_occurrence
    end
  end

  # def set_job
  #   if reminder
  #     Reminder.set_reminder_job
  #     return true
  #   end
  #   false
  # end

end
