describe SlackMessage do

  let(:reminder_text) {"play basketball at the park"}

  context "Reminder Message" do

    let(:reminder_attr) { {message_type: 'r', channel: 'C2W46HWJ2'} }

    context "Relative Time" do

      context "simple reminder, relative time, same day, seconds" do
        let(:reminder) {reminder_attr.merge(body: "vera remind me to #{reminder_text} in 1 second")}
        let(:slack_message) { SlackMessage.new(reminder) }
        let(:relative_time) {Time.now + 1}

        it "parses time" do
          expect(slack_message.time.text).to eq "in 1 second"
          expect(slack_message.time.relative).to be_within(0.1).of(relative_time)
          expect(slack_message.time.minute).to eq((relative_time).min)
          expect(slack_message.time.hour).to eq((relative_time).hour)
        end
        it "parses the date" do
          expect(slack_message.date.to_date).to eq(Date.today)
        end
        it "parses the reminder" do
          expect(slack_message.reminder).to eq(reminder_text)
        end
      end

      context "simple reminder, relative time, same day, seconds, abbreviated" do
        let(:reminder) {reminder_attr.merge(body: "vera remind me to #{reminder_text} in 5 sec")}
        let(:slack_message) { SlackMessage.new(reminder) }
        let(:relative_time) {Time.now + 5}

        it "parses time" do
          expect(slack_message.time.text).to eq "in 5 sec"
          expect(slack_message.time.relative).to be_within(0.1).of(relative_time)
          expect(slack_message.time.minute).to eq((relative_time).min)
          expect(slack_message.time.hour).to eq((relative_time).hour)
        end
        it "parses the date" do
          expect(slack_message.date.to_date).to eq(Date.today)
        end
        it "parses the reminder" do
          expect(slack_message.reminder).to eq(reminder_text)
        end
      end

      context "simple reminder, relative time, same day, minutes" do
        let(:reminder) {reminder_attr.merge(body: "vera remind me to #{reminder_text} in 5 minutes")}
        let(:slack_message) { SlackMessage.new(reminder) }
        let(:relative_time) {Time.now + 5.minutes}

        it "parses time" do
          expect(slack_message.time.text).to eq "in 5 minutes"
          expect(slack_message.time.relative).to be_within(0.1).of(relative_time)
          expect(slack_message.time.minute).to eq((relative_time).min)
          expect(slack_message.time.hour).to eq((relative_time).hour)
        end
        it "parses the date" do
          expect(slack_message.date.to_date).to eq((relative_time).to_date)
        end
        it "parses the reminder" do
          expect(slack_message.reminder).to eq(reminder_text)
        end
      end

      context "simple reminder, relative time, same day, minutes, abbreviated" do
        let(:reminder) {reminder_attr.merge(body: "vera remind me to #{reminder_text} in 5 min")}
        let(:slack_message) { SlackMessage.new(reminder) }
        let(:relative_time) {Time.now + 5.minutes}

        it "parses time" do
          expect(slack_message.time.text).to eq "in 5 min"
          expect(slack_message.time.relative).to be_within(0.1).of(relative_time)
          expect(slack_message.time.minute).to eq((relative_time).min)
          expect(slack_message.time.hour).to eq((relative_time).hour)
        end
        it "parses the date" do
          expect(slack_message.date.to_date).to eq((relative_time).to_date)
        end
        it "parses the reminder" do
          expect(slack_message.reminder).to eq(reminder_text)
        end
      end

      context "simple reminder, relative time, same day, hours" do
        let(:reminder) {reminder_attr.merge(body: "vera remind me to #{reminder_text} in 5 hours")}
        let(:slack_message) { SlackMessage.new(reminder) }
        let(:relative_time) {Time.now + 5.hours}

        it "parses time" do
          expect(slack_message.time.text).to eq "in 5 hours"
          expect(slack_message.time.relative).to be_within(0.1).of(relative_time)
          expect(slack_message.time.minute).to eq((relative_time).min)
          expect(slack_message.time.hour).to eq((relative_time).hour)
        end
        it "parses the date" do
          expect(slack_message.date.to_date).to eq((relative_time).to_date)
        end
        it "parses the reminder" do
          expect(slack_message.reminder).to eq(reminder_text)
        end
      end

      context "simple reminder, relative time, same day, hours, abbreviated" do
        let(:reminder) {reminder_attr.merge(body: "vera remind me to #{reminder_text} in 5 hrs")}
        let(:slack_message) { SlackMessage.new(reminder) }
        let(:relative_time) {Time.now + 5.hours}

        it "parses time" do
          expect(slack_message.time.text).to eq "in 5 hrs"
          expect(slack_message.time.relative).to be_within(0.1).of(relative_time)
          expect(slack_message.time.minute).to eq((relative_time).min)
          expect(slack_message.time.hour).to eq((relative_time).hour)
        end
        it "parses the date" do
          expect(slack_message.date.to_date).to eq((relative_time).to_date)
        end
        it "parses the reminder" do
          expect(slack_message.reminder).to eq(reminder_text)
        end
      end

    end

    context "Absolute Time" do

      context "simple reminder, absolute time, no date provided, before time" do
        before(:each) do
          @now = DateTime.now.localtime.beginning_of_day
          @target = @now + 14.hours + 45.minutes
        end
        let(:reminder) {reminder_attr.merge(body: "vera remind me to #{reminder_text} at 2:45 pm")}
        let(:slack_message) { SlackMessage.new(reminder) }

        it "parses time" do
          expect(slack_message.time.text).to eq "at 2:45 pm"
          expect(slack_message.time.absolute).to eq(@target)
          expect(slack_message.time.minute).to eq(45)
          expect(slack_message.time.hour(type: 24)).to eq(14)
        end
        it "parses the date" do
          byebug
          expect(slack_message.date.to_date).to eq(Date.today)
        end
        it "parses the reminder" do
          expect(slack_message.reminder).to eq(reminder_text)
        end
      end


    end
  end
end
