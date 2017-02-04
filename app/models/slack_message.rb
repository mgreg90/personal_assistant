class SlackMessage < ApplicationRecord
  belongs_to :context
  belongs_to :user, optional: true

  MESSAGE_TYPE_MAP = {
    'r' => Reminder
  }.freeze

  BOT_NAMES = ENV['SLACK_RUBY_BOT_ALIASES'].split(',').map { |bn| /#{bn}/i }.freeze

  def message_type
    @message_type ||= MESSAGE_TYPE_MAP[super]
  end

  def greeting_matches
    @greeting_matches ||= BOT_NAMES.map do |bn|
      bn.match body
    end
  end

  def greeting
    @greeting ||= greeting_matches.first[0]
  end

end
