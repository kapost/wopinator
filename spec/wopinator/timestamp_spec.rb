require 'time'

RSpec.describe Wopinator::Timestamp do
  subject { described_class.new(value) }
  let(:value) { 635655897610773532 }
  let(:time) { Time.parse('2015-04-25 23:16:01.077353239 +0300') }

  context '.to_s' do
    it 'should return the initial value as a string' do
      expect(subject.to_s).to eql(value.to_s)
    end
  end

  context '.to_i' do
    it 'should return the intial value' do
      expect(subject.to_i).to eql(value)
    end
  end

  context '.to_time' do
    it 'should return the correct unix timestamp' do
      expect(subject.to_time.to_i).to eql(time.to_i)
    end
  end

  context '.valid?' do
    let(:time_two) { Time.parse('2015-04-25 23:26:01.077353239 +0300') }

    before do
      Timecop.freeze(time_two)
    end

    after do
      Timecop.return
    end

    it 'should indicate if the timestamp is not older than 20 minutes' do
      expect(subject.valid?).to be_truthy
    end
  end

  context '.older_than_twenty_minutes?' do
    it 'should indicate if the timestamp is older than 20 minutes' do
      expect(subject.older_than_twenty_minutes?).to be_truthy
    end
  end
end
