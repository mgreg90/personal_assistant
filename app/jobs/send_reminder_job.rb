class SendReminderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @@client ||= Slack::Web::Client.new
    args.each do |reminder|
      @@client.chat_postMessage(reminder)
      Reminder.set_reminder_job
    end
  end

end
