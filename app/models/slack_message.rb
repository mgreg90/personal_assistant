class SlackMessage < ApplicationRecord
  ################################################
  # ATTRIBUTES:
  # t.string      :timezone
  # t.string      :body
  # t.string      :channel
  # t.references  :context, foreign_key: true
  # t.references  :reminder, foreign_key: true
  ################################################


  # include MessageToReminder

  belongs_to :context
  belongs_to :user, optional: true
  belongs_to :reminder, optional: true

  def body
    @body = if @body && @body.class == Message::Body
      @body
    else
      Message::Body.new(super, timezone: timezone)
    end
  end

  def body=(body)
    @body = Message::Body.new(super(body), timezone: timezone)
  end

  def greeting
    regex = /\b#{ENV['SLACK_RUBY_BOT_ALIASES']}\b/
    match(regex) ? match(regex)[0] : ''
  end

end
