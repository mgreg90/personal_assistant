class SendReminderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @@client ||= Slack::Web::Client.new
    args.each do |reminder|
      @@client.chat_postMessage(reminder)
      next_reminder = Reminder.next_occurrence
      next_rem = ReminderPresenter.new(next_reminder, channel: next_reminder.slack_messages.last.channel).to_h
      self.class.set(wait_until: next_reminder.next_occurrence).perform_later(next_rem)
    end
  end

end
