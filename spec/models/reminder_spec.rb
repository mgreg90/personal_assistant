# describe Reminder do
#   let(:user) { FactoryGirl.create :user }
#   context "::next_reminder" do
# 
#     context "WHEN there are 2 reminders, one in the past, one in an hour" do
#       before do
#         Time.zone = "UTC"
#         @reminder_past = FactoryGirl.create :reminder, user: user
#         @schedule_past = FactoryGirl.create :schedule, next_occurrence: (Time.zone.now - 1.day), reminder: @reminder_past
#         @reminder_future = FactoryGirl.create :reminder, user: user
#         @schedule_future = FactoryGirl.create :schedule, next_occurrence: (Time.zone.now + 1.day), reminder: @reminder_future
#       end
#       after do
#         Schedule.destroy_all
#         Reminder.destroy_all
#       end
#       it "SHOULD return the future reminder" do
#         expect(Reminder.next_reminder).to eq(@reminder_future)
#       end
#     end
# 
#     context "WHEN there are 2 reminders, one in an hour, one in 2 hours" do
#       before do
#         Time.zone = "UTC"
#         @reminder_sooner = FactoryGirl.create :reminder, user: user
#         @schedule_sooner = FactoryGirl.create :schedule, next_occurrence: (Time.zone.now + 1.hour), reminder: @reminder_sooner
#         @reminder_later = FactoryGirl.create :reminder, user: user
#         @schedule_later = FactoryGirl.create :schedule, next_occurrence: (Time.zone.now + 2.hours), reminder: @reminder_later
#       end
#       after do
#         Schedule.destroy_all
#         Reminder.destroy_all
#       end
#       it "SHOULD return the future reminder" do
#         expect(Reminder.next_reminder).to eq(@reminder_sooner)
#       end
#     end
# 
#     context "WHEN there are 3 reminders, one in the past, one in an hour, one in 2 hours" do
#       before do
#         Time.zone = "UTC"
#         @reminder_past = FactoryGirl.create :reminder, user: user
#         @schedule_past = FactoryGirl.create :schedule, next_occurrence: (Time.zone.now - 1.hour), reminder: @reminder_past
#         @reminder_sooner = FactoryGirl.create :reminder, user: user
#         @schedule_sooner = FactoryGirl.create :schedule, next_occurrence: (Time.zone.now + 1.hour), reminder: @reminder_sooner
#         @reminder_later = FactoryGirl.create :reminder, user: user
#         @schedule_later = FactoryGirl.create :schedule, next_occurrence: (Time.zone.now + 2.hours), reminder: @reminder_later
#       end
#       after do
#         Schedule.destroy_all
#         Reminder.destroy_all
#       end
#       it "SHOULD return the future reminder" do
#         expect(Reminder.next_reminder).to eq(@reminder_sooner)
#       end
#     end
# 
#   end
# end
