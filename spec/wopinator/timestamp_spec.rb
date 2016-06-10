require 'time'

RSpec.describe Wopinator::Timestamp do
  subject { described_class.new(value) }
  let(:value) { 635655897610773532 }
  let(:time) { Time.parse('2015-04-25 23:16:01.077353239 +0300') }

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
end
