class ReminderPresenter

  DEFAULT_REMINDER_RESPONSE = "You've got a reminder!"

  attr_reader :reminder, :text, :timezone, :time, :channel

  def initialize(reminder, options={})
    @reminder = reminder
    @text = options[:text] || DEFAULT_REMINDER_RESPONSE
    @timezone = reminder.slack_messages.last.timezone
    @time = reminder.next_schedule.next_occurrence.in_time_zone(@timezone).format_us
    @channel = reminder.slack_messages.last.channel
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
          text: reminder_text,
          footer: "Vera",
          ts: Time.now.to_i.to_s.gsub('  ', ' ')
        }
      ]
    }
  end

  def reminder_text
    <<~REM
      Reminder: #{clean_message}
      Time: #{time}
    REM
  end

  def clean_message
    reminder.message.gsub(/my/i, 'your').capitalize
  end

end
