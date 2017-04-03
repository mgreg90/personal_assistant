class SlackMessage < ApplicationRecord
  ################################################
  # ATTRIBUTES:
  # t.string      :body
  # t.string      :message_type
  # t.string      :channel
  # t.references  :context, foreign_key: true
  # t.references  :reminder, foreign_key: true
  ################################################


  # include MessageToReminder

  class WrongType < StandardError; end

  belongs_to :context
  belongs_to :user, optional: true
  belongs_to :reminder, optional: true

  def body
    if super.class == Message::Body
      super
    else
      Message::Body.new(super)
    end
  end

  def reminder
    # this is temporary, just to get the flow started so I can test Body#phrases
    body.phrases
  end

  # MESSAGE_TYPE_MAP = {
  #   'r' => {class: Reminder, regex: /remind me (to|about|that) /i}
  # }.freeze

  # def reminder
  #   @reminder ||= begin
  #     # dude this is stupid. Both of these are models and I'm creating
  #     # and not saving a new one every time?
  #     Reminder.new(reminder_hash)
  #   end
  # end

  # def reminder_hash
  #   raise WrongType, "message_type is not Reminder!" unless reminder?
  #   super
  # end

  # def message_type
  #   @message_type ||= MESSAGE_TYPE_MAP[super]
  # end
  #
  # def reminder?
  #   message_type[:class] == MESSAGE_TYPE_MAP['r'][:class]
  # end

end
