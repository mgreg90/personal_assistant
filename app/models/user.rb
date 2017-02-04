class User < ApplicationRecord

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

end
