describe Message::AtPhrase do
  context "#time" do

    context "valid time phrase" do
      context "phrase is 'at 3 pm'" do
        let(:phrase) { Message::AtPhrase.new('at 3 pm') }
        it "should return correct time hash" do
          expect(phrase.time).to eq({hour: 15, minute: 0})
        end
      end

      context "phrase is 'at 1 AM'" do
        let(:phrase) { Message::AtPhrase.new('at 1 AM') }
        it "should return correct time hash" do
          expect(phrase.time).to eq({hour: 1, minute: 0})
        end
      end

      context "phrase is 'at 12 p.m.'" do
        let(:phrase) { Message::AtPhrase.new('at 12 p.m.') }
        it "should return correct time hash" do
          expect(phrase.time).to eq({hour: 12, minute: 0})
        end
      end

      context "phrase is 'at 12 A.M.'" do
        let(:phrase) { Message::AtPhrase.new('at 12 p.m.') }
        it "should return correct time hash" do
          expect(phrase.time).to eq({hour: 12, minute: 0})
        end
      end

      context "phrase is 'at 12:30 A.M.'" do
        let(:phrase) { Message::AtPhrase.new('at 12:30 A.M.') }
        it "should return correct time hash" do
          expect(phrase.time).to eq({hour: 0, minute: 30})
        end
      end

      context "phrase is 'at 1:15 p.M.'" do
        let(:phrase) { Message::AtPhrase.new('at 12:30 A.M.') }
        it "should return correct time hash" do
          expect(phrase.time).to eq({hour: 0, minute: 30})
        end
      end
    end

    context "invalid time phrase" do

      context "phrase is 'at 12 nm'" do
        let(:phrase) { Message::AtPhrase.new('at 12 nm') }
        it "should return an error" do
          expect(phrase.time).to be_nil
        end
      end

      context "phrase is 'at 1'" do
        let(:phrase) { Message::AtPhrase.new('at 12 nm') }
        it "should return an error" do
          expect(phrase.time).to be_nil
        end
      end

      context "phrase is 'at 13 pm'" do
        let(:phrase) { Message::AtPhrase.new('at 12 nm') }
        it "should return an error" do
          expect(phrase.time).to be_nil
        end
      end

      context "phrase is 'at 0 am'" do
        let(:phrase) { Message::AtPhrase.new('at 12 nm') }
        it "should return an error" do
          expect(phrase.time).to be_nil
        end
      end

    end

  end
end
