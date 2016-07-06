RSpec.describe Wopinator::FileInfo do
  subject { described_class.new }

  context '.to_json' do
    it 'should return valid json' do
      subject.OwnerId = '13'
      subject.UserId = '42'

      json = JSON.parse(subject.to_json)

      expect(json.size).to eql(2)
      expect(json).to include({ 'OwnerId' => '13', 'UserId' => '42' })
    end

    it 'should raise error when there is an empty property' do
      subject.OwnerId = nil
      subject.UserId = '42'
      expect { subject.to_json }.to raise_error(Wopinator::FileInfo::EmptyPropertyError)
    end
  end

  context '.validate!' do
    it 'should not raise error when no empty property is found' do
      subject.OwnerId = '13'
      expect { subject.validate! }.not_to raise_error
    end

    it 'should raise error when at least one empty property is found' do
      subject.OwnerId = nil
      expect { subject.validate! }.to raise_error(Wopinator::FileInfo::EmptyPropertyError)
    end
  end
end
