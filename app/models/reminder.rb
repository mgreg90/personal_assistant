class Reminder < ApplicationRecord

  belongs_to :user
  belongs_to :context, optional: true

  has_many :recurrences

end
