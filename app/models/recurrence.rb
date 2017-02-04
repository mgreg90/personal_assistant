class Recurrence < ApplicationRecord

  belongs_to :reminder

  has_many :dateless_time_ranges
  
end
