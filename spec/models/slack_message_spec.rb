# describe SlackMessage do
#   reminder_texts =
#   [
#     {
#       body: "vera remind me to get a haircut in 5 minutes",
#       next_occurrence: Time.now + 5.minutes,
#       case: 1,
#       last_every: nil,
#       message: "get a haircut in 5 minutes",
#       last_in: "in 5 minutes",
#       reminder_hash: {
#         message: "Get a haircut",
#         status: 'A',
#         occurrence: Time.now + 5.minutes
#       }
#     },
#     {
#       body: "vera remind me to get a haircut in 2 days at 1 pm",
#       next_occurrence: (Time.now + 2.days).change(hour: 13),
#       case: 2,
#       last_every: nil,
#       message: "get a haircut in 2 days at 1 pm",
#       last_in: "in 2 days at 1 pm",
#       last_at: "at 1 pm",
#       reminder_hash: {
#         message: "Get a haircut",
#         status: 'A',
#         occurrence: (Time.now + 2.days).change(hour: 13)
#       }
#     },
#     {
#       body: "vera remind me to get a haircut at 5 pm",
#       next_occurrence: (Time.now).change(hour: 17),
#       case: 3,
#       last_every: nil,
#       message: "get a haircut at 5 pm",
#       last_at: "at 5 pm",
#       reminder_hash: {
#         message: "Get a haircut",
#         status: 'A',
#         occurrence: (Time.now).change(hour: 17)
#       }
#     },
#     {
#       body: "vera remind me to get a haircut at 5:10 pm",
#       next_occurrence: (Time.now).change(hour: 17, min: 10),
#       case: 3,
#       last_every: nil,
#       message: "get a haircut at 5:10 pm",
#       last_at: "at 5:10 pm",
#       reminder_hash: {
#         message: "Get a haircut",
#         status: 'A',
#         occurrence: (Time.now).change(hour: 17, min: 10)
#       }
#     },
#     {
#       body: "remind me that tom cheats every time at poker every saturday at 1 am",
#       next_occurrence: Chronic.parse('saturday at 1 am'),
#       case: 5,
#       last_every: "every saturday at 1 am",
#       last_at: "at 1 am",
#       message: "tom cheats every time at poker every saturday at 1 am",
#       reminder_hash: {
#         message: "Tom cheats every time at poker",
#         status: 'A',
#         recurrences_attributes: [{
#           bin_week_day: '0000001',
#           frequency_code: 'W',
#           interval: 1,
#           time: {
#             hour: 1,
#             min: 0,
#             sec: 0,
#             timezone: 'America/New_York'
#           }
#         }]
#       }
#     },
#     {
#       body: "remind me that tom cheats every time at poker every saturday at 1:45 am",
#       case: 5,
#       last_every: "every saturday at 1:45 am",
#       last_at: "at 1:45 am",
#       message: "tom cheats every time at poker every saturday at 1:45 am",
#       reminder_hash: {
#         message: "Tom cheats every time at poker",
#         status: 'A',
#         recurrences_attributes: [{
#           bin_week_day: '0000001',
#           frequency_code: 'W',
#           interval: 1,
#           time: {
#             hour: 1,
#             min: 45,
#             sec: 0,
#             timezone: 'America/New_York'
#           }
#         }]
#       }
#     },
#     {
#       body: "remind me that I have to exercise every 2 days at 6 pm",
#       case: 6,
#       last_every: "every 2 days at 6 pm",
#       last_at: "at 6 pm",
#       message: "I have to exercise every 2 days at 6 pm",
#       reminder_hash: {
#         message: "You have to exercise",
#         status: 'A',
#         recurrences_attributes: [{
#           interval: 2,
#           frequency_code: 'D',
#           time: {
#             hour: 18,
#             min: 0,
#             sec: 0,
#             timezone: 'America/New_York'
#           }
#         }],
#       }
#     },
#     {
#       body: "remind me that I have to exercise every 26 weeks at 8 a.m.",
#       case: 6,
#       last_every: "every 26 weeks at 8 a.m.",
#       last_at: "at 8 a.m.",
#       message: "I have to exercise every 26 weeks at 8 a.m.",
#       reminder_hash: {
#         message: "You have to exercise",
#         status: 'A',
#         recurrences_attributes: [{
#           interval: 26,
#           bin_week_day: Date.today.bin_day,
#           frequency_code: 'W',
#           time: {
#             hour: 8,
#             min: 0,
#             sec: 0,
#             timezone: 'America/New_York'
#           }
#         }],
#       }
#     },
#     {
#       body: "remind me that I have to exercise every 6 weeks at 8 a.m. on sundays",
#       case: 6,
#       last_every: "every 6 weeks at 8 a.m. on sundays",
#       last_at: "at 8 a.m.",
#       last_on: "on sundays",
#       message: "I have to exercise every 6 weeks at 8 a.m. on sundays",
#       reminder_hash: {
#         message: "You have to exercise",
#         status: 'A',
#         recurrences_attributes: [{
#           interval: 6,
#           bin_week_day: '1000000',
#           frequency_code: 'W',
#           time: {
#             hour: 8,
#             min: 0,
#             sec: 0,
#             timezone: 'America/New_York'
#           }
#         }],
#       }
#     },
#     {
#       body: "remind me that I have to exercise every 6 weeks on tuesdays at noon",
#       case: 6,
#       last_every: "every 6 weeks on tuesdays at noon",
#       last_at: "at noon",
#       last_on: "on tuesdays",
#       message: "I have to exercise every 6 weeks on tuesdays at noon",
#       reminder_hash: {
#         message: "You have to exercise",
#         status: 'A',
#         recurrences_attributes: [{
#           interval: 6,
#           bin_week_day: '0010000',
#           frequency_code: 'W',
#           time: {
#             hour: 12,
#             min: 0,
#             sec: 0,
#             timezone: 'America/New_York'
#           }
#         }],
#       }
#     },
#     {
#       body: "vera, remind me to do my thing everyday at noon",
#       case: 10,
#       last_every: "everyday at noon",
#       last_at: "at noon",
#       message: "do my thing everyday at noon",
#       reminder_hash: {
#         message: "Do my thing",
#         status: 'A',
#         recurrences_attributes: [{
#           bin_week_day: '1111111',
#           frequency_code: 'W',
#           interval: 1,
#           time: {
#             hour: 12,
#             min: 0,
#             sec: 0,
#             timezone: 'America/New_York'
#           }
#         }]
#       }
#     },
#     {
#       body: "vera, remind me to do my thing every weekday at noon",
#       case: 10,
#       last_every: "every weekday at noon",
#       last_at: "at noon",
#       message: "do my thing every weekday at noon",
#       reminder_hash: {
#         message: "Do my thing",
#         status: 'A',
#         recurrences_attributes: [{
#           bin_week_day: '0111110',
#           frequency_code: 'W',
#           interval: 1,
#           time: {
#             hour: 12,
#             min: 0,
#             sec: 0,
#             timezone: 'America/New_York'
#           }
#         }]
#       }
#     },
#     {
#       body: "vera, remind me to do my thing everyday at 1 pm",
#       case: 10,
#       last_every: "everyday at 1 pm",
#       last_at: "at 1 pm",
#       message: "do my thing everyday at 1 pm",
#       reminder_hash: {
#         message: "Do my thing",
#         status: 'A',
#         recurrences_attributes: [{
#           bin_week_day: '1111111',
#           frequency_code: 'W',
#           interval: 1,
#           time: {
#             hour: 13,
#             min: 0,
#             sec: 0,
#             timezone: 'America/New_York'
#           }
#         }]
#       }
#     },
#     {
#       body: "remind me that I have to exercise every 6 weeks at 8 a.m. on sundays",
#       case: 6,
#       last_every: "every 6 weeks at 8 a.m. on sundays",
#       last_at: "at 8 a.m.",
#       last_on: "on sundays",
#       message: "I have to exercise every 6 weeks at 8 a.m. on sundays",
#       reminder_hash: {
#         message: "You have to exercise",
#         status: 'A',
#         recurrences_attributes: [{
#           interval: 6,
#           bin_week_day: '1000000',
#           frequency_code: 'W',
#           time: {
#             hour: 8,
#             min: 0,
#             sec: 0,
#             timezone: 'America/New_York'
#           }
#         }],
#       }
#     }
#   ]
#
#   reminder_texts.each do |rt|
#
#     describe "unit tests" do
#
#       before(:each) do
#         @slack_message = SlackMessage.new(
#         body:           rt[:body],
#         message_type:   'r',
#         channel:        'C2W46HWJ2'
#         )
#       end
#
#       context '#last_every' do
#         it "returns #{rt[:last_every]} when body is '#{rt[:body]}'" do
#           if rt[:last_every]
#             expect(@slack_message.last_every).to eq rt[:last_every]
#           end
#         end
#       end
#
#       context '#last_in' do
#         it "returns #{rt[:last_in]} when body is '#{rt[:body]}'" do
#           if rt[:last_in]
#             expect(@slack_message.last_in).to eq rt[:last_in]
#           end
#         end
#       end
#
#       context '#last_at' do
#         it "returns #{rt[:last_at]} when body is '#{rt[:body]}'" do
#           if rt[:last_at]
#             expect(@slack_message.last_at).to eq rt[:last_at]
#           end
#         end
#       end
#
#       context '#last_on' do
#         it "returns #{rt[:last_on]} when body is '#{rt[:body]}'" do
#           if rt[:last_on]
#             expect(@slack_message.last_on).to eq rt[:last_on]
#           end
#         end
#       end
#
#       context "#message" do
#         it "returns #{rt[:message]} when body is '#{rt[:body]}'" do
#           if rt[:message]
#             expect(@slack_message.message).to eq rt[:message]
#           end
#         end
#       end
#
#       context "#reminder_hash" do
#         it "returns the correct reminder hash when body is '#{rt[:body]}'" do
#           if rt[:reminder_hash]
#             if (rt[:reminder_hash][:occurrence] rescue nil)
#               occ = rt[:reminder_hash].delete(:occurrence)
#               expect(@slack_message.reminder_hash.delete(:occurrence)).to be_within(1.second).of(occ)
#             end
#             expect(@slack_message.reminder_hash).to eq rt[:reminder_hash]
#           end
#         end
#       end
#
#       context "#reminder" do
#         it "returns the correct reminder when body is '#{rt[:body]}'" do
#           if rt[:next_occurrence]
#             next_occ = rt[:next_occurrence]
#             expect(@slack_message.reminder.next_occurrence).to be_within(1.second).of(next_occ)
#           end
#         end
#       end
#
#       context "error" do
#         it "throws an error" do
#           # if
#         end
#       end
#
#     end
#
#   end
# end
