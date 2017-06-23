namespace :development do
  
  desc "Clears 5 Main DB Tables"
  task clear_db: :environment do
    puts "=============="
    puts "Blow it all up!"
    ApplicationRecord.transaction do
      SlackMessage.destroy_all
      Schedule.destroy_all
      Context.destroy_all
      Reminder.destroy_all
      User.destroy_all
    end
    puts "=============="
    puts "Destruction Complete"
  end

end
