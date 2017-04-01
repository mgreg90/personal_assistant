class User < ApplicationRecord
  ################################################
  # ATTRIBUTES:
  # t.string      :slack_user_id
  # t.string      :slack_team_id
  ################################################

  has_one :context
  has_many :slack_messages, :through => :contexts

  has_many :reminders

  BOT_NAMES = ENV['SLACK_RUBY_BOT_ALIASES'].split(',').map { |bn| /#{bn}/i }.freeze

  def self.create_or_find(slack_team_id, slack_user_id)
    if User.exists?(slack_team_id: slack_team_id, slack_user_id: slack_user_id)
      User.find_by(slack_team_id: slack_team_id, slack_user_id: slack_user_id)
    else
      User.create(slack_team_id: slack_team_id, slack_user_id: slack_user_id)
    end
  end

  def current_or_new_context
    if context && context.before_timeout?
      context
    else
      self.context = Context.new
    end
  end

end
