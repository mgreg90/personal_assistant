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
    current_context = Context.current_or_new(current_user, slack_message)
    binding.pry
    # current_context  =  if current_user.context
    #                       current_user.context
    #                     else
    #                       Context.create!(
    #                         item_type: :reminder,
    #                         user: current_user,
    #                         slack_messages: [slack_message]
    #                       )
    #                     end
    #
    client.say(channel: data.channel, text: "you got it!")
  end

end
