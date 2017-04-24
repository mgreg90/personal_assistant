class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.datetime        :next_occurrence
      t.datetime        :last_occurrence
      t.string          :schedule_type
      t.datetime        :start_time
      t.datetime        :end_time
      t.string          :interval
      t.integer         :day_of_week
      t.string          :week_of_month
      t.string          :date_of_month
      t.string          :timezone
      t.references      :reminder, foreign_key: true

      t.timestamps
    end
  end
end
