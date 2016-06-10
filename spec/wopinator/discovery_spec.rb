RSpec.describe Wopinator::Discovery do
  subject { described_class.new(env: :test) }
  let(:response) { double(:response, code: 200, body: File.read(DISCOVERY_XML_FILE)) }

  before do
    allow(Wopinator::HTTPClient).to receive(:get).at_most(:twice).with(subject.url).and_return(response)
  end

  context '.proof_key' do
    it 'should return proof key' do
      expect(subject.proof_key.modulus).to be_an(Integer)
      expect(subject.proof_key.exponent).to be_an(Integer)
      expect(subject.proof_key.value).to be_an(String)
    end
  end

  context '.old_proof_key' do
    it 'should return old proof key' do
      expect(subject.old_proof_key.modulus).to be_an(Integer)
      expect(subject.old_proof_key.exponent).to be_an(Integer)
      expect(subject.old_proof_key.value).to be_an(String)
    end
  end

  context '.apps' do
    it 'should return an array of apps' do
      expect(subject.apps).not_to be_nil
      expect(subject.apps.size).not_to eql(0)
      expect(subject.apps.first.actions).not_to be_nil
      expect(subject.apps.first.actions.size).not_to eql(0)
    end
  end

  context '.reload' do
    it 'should reload everything' do
      expect(subject.proof_key.exponent).to be_an(Integer)
      expect(subject.old_proof_key.exponent).to be_an(Integer)

      expect(subject.apps).not_to be_nil
      expect(subject.apps.size).not_to eql(0)

      subject.reload!

      expect(subject.proof_key.exponent).to be_an(Integer)
      expect(subject.old_proof_key.exponent).to be_an(Integer)

      expect(subject.apps).not_to be_nil
      expect(subject.apps.size).not_to eql(0)
    end
  end
end
