class SlackMessage < ApplicationRecord
  belongs_to :context
  belongs_to :user, optional: true

  MESSAGE_TYPE_MAP = {
    'r' => {class: Reminder, regex: /remind me (to|about) /i}
  }.freeze

  def body
    @body ||= MsgBody.new(super)
  end

  def time
    @time ||= MsgTime.new(body.without(:greeting))
  end

  def message_type
    @message_type ||= MESSAGE_TYPE_MAP[super]
  end

end
