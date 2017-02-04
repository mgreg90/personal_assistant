class CreateContexts < ActiveRecord::Migration[5.0]
  def change
    create_table :contexts do |t|
      t.references  :user, foreign_key: true
      t.references  :reminder, foreign_key: true
      
      t.timestamps
    end
  end
end
