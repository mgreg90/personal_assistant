class AddColumnsToRecurrence < ActiveRecord::Migration[5.0]
  def change
    add_column :recurrences, :time, :string
    add_column :recurrences, :timezone, :string
  end
end
