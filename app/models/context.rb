class Context < ApplicationRecord
  ################################################
  # ATTRIBUTES:
  # t.references  :user, foreign_key: true
  # t.references  :reminder, foreign_key: true
  ################################################

  belongs_to :user, optional: true
  belongs_to :reminder, optional: true

  has_many :slack_messages, dependent: :destroy

  CONTEXT_END_TIMEOUT = 10.minutes

  def before_timeout?
    reminder.blank? && updated_at > CONTEXT_END_TIMEOUT
  end

  def type
    # TODO: write logic to determine a context's type
    Reminder
  end

end
