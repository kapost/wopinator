RSpec.describe Wopinator::Headers do
  subject { described_class.new(request) }

  let(:timestamp) { '13666' }
  let(:proof) { 'proof' }
  let(:old_proof) { 'old_proof' }

  let(:env) { {
    'HTTP_X_WOPI_PROOF' => proof,
    'HTTP_X_WOPI_PROOFOLD' => old_proof,
    'HTTP_X_WOPI_TIMESTAMP' => timestamp,
    'SERVER_PATH' => '/'
  } }

  let(:request) { double(:request, env: env) }

  context 'parsing headers' do
    context 'when HTTP is missing' do
      let(:env) { {'X_WOPI_PROOF' => proof } }

      it 'should work' do
        expect(subject.count).to eql(1)
        expect(subject.get(:proof)).to eql(proof)
      end
    end

    context 'when it uses - instead of _' do
      let(:env) { {'X-WOPI-PROOF' => proof } }

      it 'should work' do
        expect(subject.count).to eql(1)
        expect(subject.get(:proof)).to eql(proof)
      end
    end

    context 'when it is mixed case' do
      let(:env) { {'X_wopi-Proof' => proof } }

      it 'should work' do
        expect(subject.count).to eql(1)
        expect(subject.get(:proof)).to eql(proof)
      end
    end
  end

  context '.get' do
    it 'should return valid wopi header' do
      expect(subject.count).to eql(3)
      expect(subject.get(:proof)).to eql(proof)
      expect(subject.get(:proofold)).to eql(old_proof)
      expect(subject.get(:timestamp)).to eql(timestamp)
    end

    it 'should not return an invalid wopi header' do
      expect(subject.get(:server_path)).to be_nil
    end
  end

  context '.set' do
    it 'should set the value for the given header' do
      expect(subject.set(:proofold, 'kapost')).to eql('kapost')
      expect(subject.get(:proofold)).to eql('kapost')
    end
  end

  context '.each' do
    it 'should iterate' do
      subject.each do |k, v|
        expect(k).to be_an(Symbol)
        expect(v).to be_an(String)
      end
    end
  end
end
