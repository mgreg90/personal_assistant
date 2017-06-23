describe Schedify do

  context "#nickel" do
    context 'WHEN timezone is "Eastern Time (US & Canada)"' do
      before do
        Time.zone = 'Eastern Time (US & Canada)'
      end
      context 'WHEN right now is 12:00 PM May 10, 2017' do
        let(:now) {Time.zone.parse('2017-05-10 12:00:00')}

        context 'WHEN body is "do this today at 10pm"' do
          let(:correct_date) {now.change(hour: 22)}
          let(:occurrences) {Schedify.parse("do this today at 10pm").nickel.occurrences}

          it "returns one occurrence" do
            expect(occurrences.length).to eq(1)
          end

          it "returns an occurrence of type = single" do
            expect(occurrences.first[:type]).to eq(:single)
          end

          it "returns a start time of May 10, 2017 10:00PM EDT" do
            expect(occurrences.first[:start_time]).to eq(correct_date)
          end

        end
        context 'WHEN body is "do this at 10pm"' do
          let(:correct_date) {now.change(hour: 22)}
          let(:occurrences) {Schedify.parse("do this at 10pm").nickel.occurrences}

          it "returns one occurrence" do
            expect(occurrences.length).to eq(1)
          end

          it "returns an occurrence of type = single" do
            expect(occurrences.first[:type]).to eq(:single)
          end

          it "returns a start time of May 10, 2017 10:00PM EDT" do
            expect(occurrences.first[:start_time]).to eq(correct_date)
          end

        end
        context 'WHEN body is "do this tomorrow at 10am"' do
          let(:correct_date) {now.change(day: 11, hour: 10)}
          let(:occurrences) {Schedify.parse("do this tomorrow at 10am").nickel.occurrences}

          it "returns one occurrence" do
            expect(occurrences.length).to eq(1)
          end

          it "returns an occurrence of type = single" do
            expect(occurrences.first[:type]).to eq(:single)
          end

          it "returns a start time of May 11, 2017 10:00AM EDT" do
            expect(occurrences.first[:start_time]).to eq(correct_date)
          end

        end
        context 'WHEN body is "do this at 10am"' do
          let(:correct_date) {now.change(day: 11, hour: 10)}
          let(:occurrences) {Schedify.parse("do this at 10am").nickel.occurrences}

          it "returns one occurrence" do
            expect(occurrences.length).to eq(1)
          end

          it "returns an occurrence of type = single" do
            expect(occurrences.first[:type]).to eq(:single)
          end

          it "returns a start time of May 11, 2017 10:00AM EDT" do
            expect(occurrences.first[:start_time]).to eq(correct_date)
          end

        end
      end
    end
  end

end
