class ReminderPresenter

  DEFAULT_REMINDER_RESPONSE = "You've got a reminder!"

  attr_reader :reminder, :text, :channel

  def initialize(reminder, options={})
    @reminder = reminder
    @text = options[:text] || DEFAULT_REMINDER_RESPONSE
    @channel = options[:channel]
  end

  def to_h
    h = default
    h[:channel] = channel if channel
    h
  end

  private

  def default
    {
      as_user: true,
      text: text,
      attachments: [
        {
          color: "#36a64f",
          text: "Reminder: #{reminder.message.capitalize}"\
            "\nTime: #{reminder.next_occurrence.localtime.format_us}",
          footer: "Vera",
          ts: Time.now.to_i.to_s
        }
      ]
    }
  end

end
