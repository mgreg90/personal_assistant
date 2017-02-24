class Bot < SlackRubyBot::Bot

  TEST_RESPONSE = "Alive and well!"

  command 'test' do |client, data|
    client.say(channel: data.channel, text: TEST_RESPONSE)
  end

  scan SlackMessage::MESSAGE_TYPE_MAP['r'][:regex] do |client, data, match|
    current_user = User.create_or_find(data.team, data.user)
    slack_message = SlackMessage.new(
      body:           data['text'],
      message_type:   'r',
      channel:        data.channel
    )
    current_context = current_user.current_or_new_context

    current_user.context = current_context
    reminder = Reminder.build_from_slack_message(slack_message, current_context)
    current_user.reminders << reminder
    current_context.slack_messages << slack_message
    SendReminderJob.set(wait_until: reminder.next_occurrence)
      .perform_later(ReminderPresenter.new(reminder, channel: slack_message.channel).to_h)

    client.say(channel: data.channel, text: "you got it!")
  end

  command 'ping' do |_, _, _|
  end

  def self.smart_client
    @smart_client ||= Slack::Web::Client.new
  end

end
