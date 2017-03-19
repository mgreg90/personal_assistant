class SlackMessage < ApplicationRecord

  include MessageToReminder

  class WrongType < StandardError; end

  belongs_to :context
  belongs_to :user, optional: true

  MESSAGE_TYPE_MAP = {
    'r' => {class: Reminder, regex: /remind me (to|about|that) /i}
  }.freeze

  def reminder
    @reminder ||= begin
      Reminder.new(reminder_hash)
    end
  end

  def reminder_hash
    raise WrongType, "message_type is not Reminder!" unless reminder?
    super
  end

  def message_type
    @message_type ||= MESSAGE_TYPE_MAP[super]
  end

  def reminder?
    message_type[:class] == MESSAGE_TYPE_MAP['r'][:class]
  end

end
