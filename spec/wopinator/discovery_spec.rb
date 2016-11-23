RSpec.describe Wopinator::Discovery do
  subject { described_class.new(env: :test) }
  let(:response) { double(:response, code: 200, body: File.read(DISCOVERY_XML_FILE)) }
  let(:src) { 'https://contoso.com/wopi/files/13666' }

  before do
    allow(Wopinator::HTTPClient).to receive(:get).at_most(:twice).with(subject.url).and_return(response)
  end

  context 'discovery xml is not available' do
    let(:response) { double(:response, code: 404) }

    it 'should not crash' do
      expect(subject.apps).not_to be_nil
      expect(subject.apps.size).to eql(0)
    end
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

  context '.resolve' do
    it 'should return an empty action url if no extension was provided' do
      metadata = subject.resolve('editnew', nil)

      expect(metadata).not_to be_nil
      expect(metadata.favicon_url).to be_nil
      expect(metadata.action_url).to be_nil
    end

    it 'should return app metadata by action name and extension' do
      metadata = subject.resolve('view', 'wopitest', src)

      expect(metadata).not_to be_nil
      expect(metadata.favicon_url).not_to be_nil
      expect(metadata.action_url).not_to be_nil
      expect(metadata.action_url).to include('WopiTestFrame.aspx')
      expect(metadata.action_url).to include('contoso.com')
    end

    it 'should preserve certain placeholder query parameters in the action url' do
      metadata = subject.resolve('editnew', 'pptx', src, { 'BUSINESS_USER' => '1' })

      expect(metadata).not_to be_nil
      expect(metadata.favicon_url).not_to be_nil
      expect(metadata.action_url).not_to be_nil

      expected_query = { 'New' => '1', 'PowerPointView' => 'EditView', 'WOPISrc' => src, 'IsLicensedUser' => '1' }
      query = Addressable::URI.parse(metadata.action_url).query_values

      expect(query).to be_an(Hash)
      expect(query.size).to eql(4)
      expect(query).to include(expected_query)

      metadata = subject.resolve('edit', 'docx', src, { 'BUSINESS_USER' => '1' })

      expect(metadata).not_to be_nil
      expect(metadata.favicon_url).not_to be_nil
      expect(metadata.action_url).not_to be_nil

      expected_query = { 'WOPISrc' => src, 'IsLicensedUser' => '1' }
      query = Addressable::URI.parse(metadata.action_url).query_values

      expect(query).to be_an(Hash)
      expect(query.size).to eql(2)
      expect(query).to include(expected_query)

      metadata = subject.resolve('view', 'wopitest', src, { 'BUSINESS_USER' => '1', 'VALIDATOR_TEST_CATEGORY' => 'test' })

      expect(metadata).not_to be_nil
      expect(metadata.favicon_url).not_to be_nil
      expect(metadata.action_url).not_to be_nil

      expected_query = { 'WOPISrc' => src, 'testcategory' => 'test' }

      query = Addressable::URI.parse(metadata.action_url).query_values

      expect(query).to be_an(Hash)
      expect(query.size).to eql(2)
      expect(query).to include(expected_query)
    end

    it 'should remove placeholder query parameters from action url' do
      metadata = subject.resolve('editnew', 'pptx', src)

      expect(metadata).not_to be_nil
      expect(metadata.favicon_url).not_to be_nil
      expect(metadata.action_url).not_to be_nil

      expected_query = { 'New' => '1', 'PowerPointView' => 'EditView', 'WOPISrc' => src }
      query = Addressable::URI.parse(metadata.action_url).query_values

      expect(query).to be_an(Hash)
      expect(query.size).to eql(3)
      expect(query).to include(expected_query)

      metadata = subject.resolve('view', 'wopitest', src)

      expect(metadata).not_to be_nil
      expect(metadata.favicon_url).not_to be_nil
      expect(metadata.action_url).not_to be_nil

      expected_query = { 'WOPISrc' => src }

      query = Addressable::URI.parse(metadata.action_url).query_values

      expect(query).to be_an(Hash)
      expect(query.size).to eql(1)
      expect(query).to include(expected_query)

      metadata = subject.resolve('edit', 'docx')

      expect(metadata).not_to be_nil
      expect(metadata.favicon_url).not_to be_nil
      expect(metadata.action_url).not_to be_nil

      query = Addressable::URI.parse(metadata.action_url).query_values

      expect(query).to be_nil
    end
  end
end
