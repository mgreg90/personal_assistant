class Reminder < ApplicationRecord

  belongs_to :user

  has_one :context

  has_many :recurrences

  def self.build_from_slack_message(message, context = nil)
    reminder = new(message: message.reminder, status: "A", context: context)
    if message.date.recurring?
    else
      reminder.occurrence = message.time.relative
    end
    reminder
  end

  def next_occurrence
    occurrence
  end

end
