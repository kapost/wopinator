RSpec.describe Wopinator::NullCache do
  subject { described_class.new }
  let(:key) { 'key' }
  let(:options) { { expires_in: 3600 } }
  let(:value) { 13 }

  context '.fetch' do
    it 'should return the value of the given block' do
      expect(subject.fetch(key, options) { value }).to eql(value)
    end
  end

  context '.delete' do
    it 'should return true' do
      expect(subject.delete(key)).to be_truthy
    end
  end
end
