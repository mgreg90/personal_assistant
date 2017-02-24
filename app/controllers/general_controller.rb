class GeneralController < ApplicationController

  class InvalidToken < StandardError; end

  CHANNEL = 'C49Q3HCTD'

  def ping
    if valid_token?
      Slack::Web::Client.new.chat_postMessage(as_user: true, channel: CHANNEL, text: "pong!")
    else
      raise InvalidToken
    end
  end


  def start_conversation
    render json: params
    # Context.new(params)
  end

  private
  def valid_token?
    ENV['SLACK_PING_TOKEN'] == params[:token]
  end

  def _params

  end

end
