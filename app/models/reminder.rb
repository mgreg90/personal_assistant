class Reminder < ApplicationRecord
  ################################################
  # ATTRIBUTES:
  # t.text        :message
  # t.string      :status
  # t.references  :user, foreign_key: true
  ################################################


  belongs_to :user

  has_one :context

  has_many :schedules, autosave: true
  has_many :slack_messages

  after_save :set_reminder_job

  ACTIVE_STATUS = 'A'.freeze
  INACTIVE_STATUS = 'I'.freeze

  def self.next_reminder(ref_time=Time.zone.now)
    joins(:schedules).select("reminders.*, schedules.next_occurrence").where("schedules.next_occurrence > ?", ref_time).order("schedules.next_occurrence DESC").limit(1).first
  end

  def self.set_reminder_job
    if next_reminder
      SendReminderJob.set(wait_until: next_reminder.next_schedule.next_occurrence)
      .perform_later(ReminderPresenter.new(next_reminder).to_h)#, channel: next_reminder.slack_message.channel).to_h)
    end
  end

  def save_schedules
    schedules.each(&:save)
  end

  def next_schedule
    # TODO: Test this!
    schedules.sort { |sched1, sched2| sched1.next_occurrence <=> sched2.next_occurrence }.first
  end

  def set_reminder_job
    self.class.set_reminder_job
  end

end
