class SlackBot < SlackRubyBot::Bot

  class InternalError < StandardError; end

  TEST_RESPONSE = "Alive and well!".freeze

  command 'test' do |client, data|
    client.say(channel: data.channel, text: TEST_RESPONSE)
  end

  scan Message::Phrase::Command::REMINDER do |client, data, match|

    current_user = User.create_or_find(data.team, data.user)
    current_context = current_user.current_or_new_context

    timezone = client.store.users[data.user].tz

    slack_message = SlackMessage.new(
      timezone:       timezone,
      body:           data['text'],
      channel:        data.channel,
      context:        current_context
    )
    reminder = Reminder.new(
      context:          current_context,
      slack_messages:   [slack_message],
      message:          slack_message.body.body_phrase,
      status:           'A',
      user:             current_user
    )
    reminder.save!
    slack_message.save!
    slack_message.body.time_phrase.occurrences.map do |occ|
      Schedule.create!(occ.merge(reminder: reminder))
    end
    binding.pry
    SendReminderJob.set(wait_until: Reminder.next_occurrence)
      .perform_later(ReminderPresenter.new(reminder, channel: slack_message.channel).to_h)

    byebug

    if ENV['RAILS_ENV'] == "development"
      client.say(channel: data.channel, text: "development\nTime: #{Time.now}")
    else
      client.say(channel: data.channel, text: "you got it!\nTime: #{Time.now}")
    end
  end

  command 'ping' do |client, data, _|
    client.say(channel: data.channel, text: "pong!")
  end

  def self.smart_client
    @smart_client ||= Slack::Web::Client.new
  end

end
