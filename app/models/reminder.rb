class Reminder < ApplicationRecord
  ################################################
  # ATTRIBUTES:
  # t.text        :message
  # t.string      :status
  # t.datetime    :occurrence
  # t.references  :user, foreign_key: true
  ################################################


  belongs_to :user
  belongs_to :reminder_type

  has_one :context

  has_many :recurrences
  has_many :slack_messages

  accepts_nested_attributes_for :recurrences
  accepts_nested_attributes_for :reminder_type

  ACTIVE_STATUS = 'A'.freeze
  WEEKLY_FREQUENCY = 'W'.freeze
  DAILY_FREQUENCY = 'D'.freeze



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
  def self.next_occurrence
    where("occurrence >= ?", DateTime.now).order("occurrence ASC").limit(1).first
  end

  def next_occurrence
    occurrence || begin

    end
  end

end
