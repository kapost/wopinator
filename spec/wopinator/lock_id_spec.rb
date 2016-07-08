RSpec.describe Wopinator::LockId do
  let(:id) { 'id' }
  subject { described_class.new(id) }

  context 'comparison' do
    context 'when they are same' do
      it 'should return true' do
        expect(subject).to eql(described_class.new('id'))
      end
    end

    context 'when they are different' do
      it 'should return true' do
        expect(subject).not_to eql(described_class.new('newid'))
      end
    end
  end

  context '.to_s' do
    it 'should return the id' do
      expect(subject.to_s).to eql('id')
    end
  end

  context '.present?' do
    context 'when not empty' do
      it 'should return true' do
        expect(subject.present?).to be_truthy
      end
    end

    context 'when empty' do
      let(:id) { '' }
      it 'should return false' do
        expect(subject.present?).to be_falsy
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

  context '.valid?' do
    context 'when id is valid' do
      it 'should return true' do
        expect(subject.valid?).to be_truthy
      end
    end

    context 'when id empty' do
      let(:id) { '' }

      it 'should return false' do
        expect(subject.valid?).to be_falsy
      end
    end

    context 'when id is too long' do
      let(:id) { 'A' * 2048 }

      it 'should return false' do
        expect(subject.valid?).to be_falsy
      end
    end

    context 'when id contains non printable characters' do
      let(:id) { "lola\f\d\x00dog" }

      it 'should return false' do
        expect(subject.valid?).to be_falsy
      end
    end
  end
end
