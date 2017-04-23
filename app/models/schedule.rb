class Schedule < ApplicationRecord
  ################################################
  # ATTRIBUTES:
  # t.string      :bin_week_day
  # t.integer     :frequency_code
  # t.integer     :month_day
  # t.string      :bin_month_week
  # t.integer     :interval
  # t.string      :time
  # t.string      :timezone
  # t.references  :reminder, foreign_key: true
  ################################################



  belongs_to :reminder

  # has_many :dateless_time_ranges

end
