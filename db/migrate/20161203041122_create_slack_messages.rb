class CreateSlackMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_messages do |t|
      t.string      :timezone
      t.string      :body
      t.string      :channel
      t.references  :context, foreign_key: true
      t.references  :reminder, foreign_key: true

      t.timestamps
    end
  end
end
