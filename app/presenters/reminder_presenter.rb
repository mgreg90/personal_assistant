class ReminderPresenter

  DEFAULT_REMINDER_RESPONSE = "You've got a reminder!"

  attr_reader :reminder, :text, :channel, :type

  def initialize(reminder, options={})
    @reminder = reminder
    @text = options[:text] || DEFAULT_REMINDER_RESPONSE
    @channel = options[:channel]
    @type = options[:type]
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
          text: "Reminder: #{clean_reminder}"\
            "\nTime: #{time}",
          footer: "Vera",
          ts: Time.now.to_i.to_s
        }
      ]
    }
  end

  def time
    # byebug
    if slack?

    else
      reminder.next_occurrence.localtime.format_us
    end
  end

  def clean_reminder
    reminder.message.gsub(/my/i, 'your').capitalize
  end

  def slack?
    [:slack, 'slack'].include?(type)
  end

end
