RSpec.describe Wopinator::Lock do
  let(:time) { Time.parse('2015-04-25 23:26:01 +0300') }
  let(:id) { 'id' }
  let(:old_id) { nil }
  let(:timestamp) { time.to_s }

  subject { described_class.new(id, old_id, timestamp) }

  before do
    Timecop.freeze(time)
  end

  after do
    Timecop.return
  end

  context 'id old_id and timestamp' do
    it 'should be converted' do
      expect(subject.id).to be_an(Wopinator::LockId)
      expect(subject.old_id).to be_an(Wopinator::LockId)
      expect(subject.timestamp).to be_an(Time)
    end
  end

  context 'comparison' do
    context 'when they are same' do
      it 'should return true' do
        expect(subject).to eql(described_class.new(id, nil, timestamp))
      end
    end

    context 'when they are different' do
      it 'should return true' do
        expect(subject).not_to eql(described_class.new('newid', nil, timestamp))
      end
    end

    context 'when does not have old id' do
      let(:id) { 'newoldid' }
      
      it 'should return true' do
        expect(subject).to eql(described_class.new('newid', 'newoldid', timestamp))
      end
    end

    context 'when it has old id' do
      let(:old_id) { 'oldid' }

      it 'should return true' do
        expect(subject).to eql(described_class.new('oldid', nil, timestamp))
      end
    end

    context 'when both have old id' do
      let(:old_id) { 'oldid' }

      it 'should return true' do
        expect(subject).to eql(described_class.new(id, 'newoldid', timestamp))
      end
    end

    context 'when is invalid' do
      let(:id) { '' }

      it 'should return false' do
        expect(subject).not_to eql(described_class.new(id, nil, timestamp))
      end
    end

    context 'when other is invalid' do
      it 'should return false' do
        expect(subject).not_to eql(described_class.new('', nil, timestamp))
      end
    end

    context 'when both are invalid' do
      let(:id) { '' }

      it 'should return false' do
        expect(subject).not_to eql(described_class.new('', nil, timestamp))
      end
    end
  end

  context '.clear!' do
    it 'should clear the lock' do
      expect(subject.valid?).to be_truthy
      expect(subject.empty?).to be_falsy
      expect(subject.expired?).to be_falsy

      Timecop.return
      subject.clear!

      expect(subject.valid?).to be_falsy
      expect(subject.empty?).to be_truthy
      expect(subject.expired?).to be_truthy
    end
  end

  context '.set' do
    it 'should set id and update timestamp' do
      expect(subject.id).to eql(id)
      expect(subject.timestamp).to eql(time)

      Timecop.return
      subject.set('newid')

      expect(subject.id).to eql('newid')
      expect(subject.timestamp).to be > time
    end
  end

  context '.touch!' do
    it 'should update timestamp' do
      expect(subject.timestamp).to eql(time)
     
      Timecop.return
      subject.touch!

      expect(subject.timestamp).to be > time
    end
  end

  context '.expired?' do
    context 'when is not expired' do
      it 'should return false' do
        expect(subject.expired?).to be_falsy
      end
    end

    context 'when is expired' do
      it 'should return true' do
        Timecop.return
        expect(subject.expired?).to be_truthy
      end
    end
  end

  context '.invalid?' do
    context 'when invalid' do
      let(:id) { '' }

      it 'should return true' do
        expect(subject.invalid?).to be_truthy
      end
    end

    context 'when not invalid' do
      it 'should return false' do
        expect(subject.invalid?).to be_falsy
      end
    end

    context 'when expired' do
      it 'should return false' do
        Timecop.return
        expect(subject.invalid?).to be_truthy
      end
    end
  end

  context '.valid?' do
    context 'when id is valid' do
      it 'should return true' do
        expect(subject.valid?).to be_truthy
      end
    end

    context 'when is not valid' do
      let(:id) { '' }

      it 'should return false' do
        expect(subject.valid?).to be_falsy
      end
    end

    context 'when expired' do
      it 'should return false' do
        Timecop.return
        expect(subject.valid?).to be_falsy
      end
    end
  end

  context '.empty?' do
    context 'when not empty' do
      it 'should return false' do
        expect(subject.empty?).to be_falsy
      end
    end

    context 'when empty' do
      let(:id) { '' }
      it 'should return true' do
        expect(subject.empty?).to be_truthy
      end
    end
  end
end
