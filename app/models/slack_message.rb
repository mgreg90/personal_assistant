class SlackMessage < ApplicationRecord

  class WrongType < StandardError; end

  belongs_to :context
  belongs_to :user, optional: true

  MESSAGE_TYPE_MAP = {
    'r' => {class: Reminder, regex: /remind me (to|about) /i}
  }.freeze

  def body
    @body ||= MsgBody.new(super).strip
  end

  def time
    @time ||= MsgTime.new(body.stripped)
  end

  def date
    @date ||= MsgDate.new(body.stripped(msg_time: time, type_regex: message_type[:regex])).strip
  end

  def reminder
    @reminder ||= begin
      if message_type[:class] != MESSAGE_TYPE_MAP['r'][:class]
        raise WrongType, "message_type is not Reminder!"
      end
      body.stripped(msg_time: time, msg_date: date, type_regex: message_type[:regex])
    end
  end

  def message_type
    @message_type ||= MESSAGE_TYPE_MAP[super]
  end

end
