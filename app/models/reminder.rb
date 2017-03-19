class Reminder < ApplicationRecord

  belongs_to :user

  has_one :context

  has_many :recurrences

  accepts_nested_attributes_for :recurrences

  ACTIVE_STATUS = 'A'.freeze
  WEEKLY_FREQUENCY = 'W'.freeze



  # def self.build_from_slack_message(message, context = nil)
  #   reminder = new(message: message.reminder, status: "A", context: context)
  #   if message.date.recurring?
  #   else
  #     reminder.occurrence = if message.time.relative?
  #       message.time.relative
  #     elsif message.time.absolute?
  #       message.time.absolute
  #     end
  #   end
  #   reminder
  # end
  #
  # def self.next_occurrence
  #   where("occurrence >= ?", DateTime.now).order("occurrence ASC").limit(1).first
  # end
  #
  # def next_occurrence
  #   occurrence
  # end

end
