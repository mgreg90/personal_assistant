class Bot < SlackRubyBot::Bot

  command 'test' do |client, data|
    client.say(channel: data.channel, text: "alive and well!")
  end

  scan SlackMessage::MESSAGE_TYPE_MAP['r'][:regex] do |client, data, match|
    current_user = User.create_or_find(data.team, data.user)
    slack_message = SlackMessage.new(
      body: data['text'],
      message_type: 'r'
    )
    current_context = current_user.current_or_new_context

    current_user.context = current_context
    reminder = Reminder.build_from_slack_message(slack_message, current_context)
    current_user.reminders << reminder
    current_context.slack_messages << slack_message
    SendReminderJob.set(wait_until: reminder.next_occurrence)
      .perform_later(reminder: reminder, channel: data.channel)

    client.say(channel: data.channel, text: "you got it!")
  end

  def self.send_reminder(client, reminder)
    client.say(channel: "C2W46HWJ2", text: reminder.message)
  end

end
