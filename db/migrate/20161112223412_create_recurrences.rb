class CreateRecurrences < ActiveRecord::Migration[5.0]
  def change
    create_table :recurrences do |t|
      t.string      :bin_week_day
      t.integer     :frequency_code
      t.integer     :month_day
      t.string      :bin_month_week
      t.integer     :interval
      t.string      :time
      t.string      :timezone
      t.references  :reminder, foreign_key: true

      t.timestamps
    end
  end
end
