RSpec.describe Wopinator::Xml do
  subject { described_class }
  let(:value) { 'BgIAAACkAABSU0ExAAgAAAEAAQDFEthb5dkE+fGnJgsmY3IXmoFxj1cOwVYLpLNTEksnVRzbXcPfaSl/kFxn5b4QajhH1sTtXECZY6ZUyiDi1NG5ukFc9Fppgt0ywnuJqNBRWPfvLTOaVZRTtr8X8hqL+dPldOI3qFUW2zF6DEsAO9y74l3s6MqNjawCME5X0jb28TOrbXXsDfIGLEN3VBFO3wyhlRZKOmR9ZiqxQbpOz0Ltgv3HYci9OVN9c8YYV5T+fHI0Wtxg4F9lJHlB6MHPV9seVqr4ieM027NG89LhHm9BJEtceII09JgmkwLFUB/s2YGirUwZewk0efw1GL861PE7Vjdn2bIdmGSCRfFQlnPQ' }
  let(:xml) { File.read(DISCOVERY_XML_FILE) }

  context '#parse' do
    it 'should parse xml' do
      result = subject.parse(xml)
      expect(result).to be_an(OpenStruct)
      expect(result.wopi_discovery).not_to be_nil
      expect(result.wopi_discovery.proof_key).not_to be_nil
      expect(result.wopi_discovery.proof_key.value).to eql(value)
      expect(result.wopi_discovery.net_zone).not_to be_nil
      expect(result.wopi_discovery.net_zone.apps).not_to be_nil
      expect(result.wopi_discovery.net_zone.apps.size).not_to eql(0)
      expect(result.wopi_discovery.net_zone.apps.first.name).to eql('Excel')
      expect(result.wopi_discovery.net_zone.apps.first.actions).not_to be_nil
      expect(result.wopi_discovery.net_zone.apps.first.actions.size).not_to eql(0)
      expect(result.wopi_discovery.net_zone.apps.first.actions.first.name).to eql('view')
      expect(result.wopi_discovery.net_zone.apps.last.name).to eql('WordPrague')
      expect(result.wopi_discovery.net_zone.apps.last.actions).not_to be_nil
      expect(result.wopi_discovery.net_zone.apps.last.actions.size).not_to eql(0)
      expect(result.wopi_discovery.net_zone.apps.last.actions.first.name).to eql('editnew')
    end

    context 'with older nori' do
      let(:older_nori) do
        Class.new(Nori) do
          class << self
            def parse(xml, parser)
              new(parser: parser).parse(xml)
            end
          end
        end
      end

      before do
        allow(subject).to receive(:parser_class).and_return(older_nori)
      end

      it 'should parse xml' do
        result = subject.parse(xml)
        expect(result).to be_an(OpenStruct)
        expect(result.wopi_discovery).not_to be_nil
        expect(result.wopi_discovery.proof_key).not_to be_nil
        expect(result.wopi_discovery.proof_key.value).to eql(value)
        expect(result.wopi_discovery.net_zone).not_to be_nil
        expect(result.wopi_discovery.net_zone.apps).not_to be_nil
        expect(result.wopi_discovery.net_zone.apps.size).not_to eql(0)
        expect(result.wopi_discovery.net_zone.apps.first.name).to eql('Excel')
        expect(result.wopi_discovery.net_zone.apps.first.actions).not_to be_nil
        expect(result.wopi_discovery.net_zone.apps.first.actions.size).not_to eql(0)
        expect(result.wopi_discovery.net_zone.apps.first.actions.first.name).to eql('view')
        expect(result.wopi_discovery.net_zone.apps.last.name).to eql('WordPrague')
        expect(result.wopi_discovery.net_zone.apps.last.actions).not_to be_nil
        expect(result.wopi_discovery.net_zone.apps.last.actions.size).not_to eql(0)
        expect(result.wopi_discovery.net_zone.apps.last.actions.first.name).to eql('editnew')
      end
    end
  end
end
