class Context < ApplicationRecord

  belongs_to :user, optional: true

  has_many :reminders
  has_many :slack_messages

  def self.current_or_new(user, message=nil)
    if user.context
      user.context
    else
      create!(
        user: user,
        slack_messages: [message]
      )
    end
  end

end
