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
    Message::Body.new(super)
  end

  def body=(body)
    Message::Body.new(super(body))
  end

  def greeting
    regex = /\b#{ENV['SLACK_RUBY_BOT_ALIASES']}\b/
    match(regex) ? match(regex)[0] : ''
  end

end
