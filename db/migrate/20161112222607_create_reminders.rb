class CreateReminders < ActiveRecord::Migration[5.0]
  def change
    create_table :reminders do |t|
      t.text        :message
      t.string      :status
      t.references  :user, foreign_key: true

      t.timestamps
    end
  end
end
