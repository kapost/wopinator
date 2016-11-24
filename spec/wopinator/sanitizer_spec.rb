RSpec.describe Wopinator::Sanitizer do
  subject { described_class }
  let(:filename) { 'demo+AF8-/filename+AF0-+ACY-+-' }

  context '#decode' do
    let(:decoded_filename) { 'demo_/filename]&+' }

    it 'should decode' do
      expect(subject.decode(filename)).to eql(decoded_filename)
    end
  end

  context '#sanitize' do
    let(:sanitized_filename) { 'demo_AF8-_filename_AF0-_ACY-_-' }

    it 'should sanitize' do
      expect(subject.sanitize(filename)).to eql(sanitized_filename)
    end
  end
end
