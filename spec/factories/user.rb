FactoryGirl.define do
  factory :user do
    slack_user_id { Forgery(:basic).password }
    slack_team_id { Forgery(:basic).password }
  end
end
