class Reminder < ApplicationRecord
  ################################################
  # ATTRIBUTES:
  # t.text        :message
  # t.string      :status
  # t.references  :user, foreign_key: true
  ################################################


  belongs_to :user

  has_one :context

  has_many :schedules
  has_many :slack_messages

  accepts_nested_attributes_for :schedules

  ACTIVE_STATUS = 'A'.freeze
  INACTIVE_STATUS = 'I'.freeze

  def self.next_reminder
    joins(:schedules).select("reminders.*, schedules.next_occurrence").where("schedules.next_occurrence > ?", Time.zone.now).order("schedules.next_occurrence ASC").limit(1).first
  end

end
