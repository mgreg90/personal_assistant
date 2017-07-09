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
    
    slack_message = SlackMessage.create!(
      timezone:       timezone,
      body:           data['text'],
      channel:        data.channel,
      context:        current_context
    )
    ApplicationRecord.transaction do
      schedules = slack_message.body.time_phrase.to_schedules.map { |sched| Schedule.new(sched) }
      reminder = Reminder.create!(
        context:              current_context,
        slack_messages:       [slack_message],
        message:              slack_message.body.body_phrase,
        status:               'A',
        user:                 current_user,
        schedules:            schedules
      )
    end
    
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
