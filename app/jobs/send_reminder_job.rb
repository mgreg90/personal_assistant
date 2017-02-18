class SendReminderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    client = Slack::Web::Client.new
    args.each do |reminder|
      client.chat_postMessage(channel: reminder[:channel], text: reminder[:reminder].message, as_user: true)
      next_reminder = Reminder.next_occurrence
      self.class.set(wait_until: next_reminder.next_occurrence).perform_later(client, next_reminder)
    end
  end

end
