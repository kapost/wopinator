RSpec.describe Wopinator::Request do
  subject { described_class.new(request, env: :test) }
  let(:response) { double(:response, code: 200, body: File.read(DISCOVERY_XML_FILE)) }

  let(:access_token) { "yZhdN1qgywcOQWhyEMVpB6NE3pvBksvcLXsrFKXNtBeDTPW%2fu62g2t%2fOCWSlb3jUGaz1zc%2fzOzbNgAredLdhQI1Q7sPPqUv2owO78olmN74DV%2fv52OZIkBG%2b8jqjwmUobcjXVIC1BG9g%2fynMN0itZklL2x27Z2imCF6xELcQUuGdkoXBj%2bI%2bTlKM" }
  let(:timestamp) { 635655897610773532 }
  let(:url) { "https://contoso.com/wopi/files/vHxYyRGM8VfmSGwGYDBMIQPzuE+sSC6kw+zWZw2Nyg?access_token=yZhdN1qgywcOQWhyEMVpB6NE3pvBksvcLXsrFKXNtBeDTPW%2fu62g2t%2fOCWSlb3jUGaz1zc%2fzOzbNgAredLdhQI1Q7sPPqUv2owO78olmN74DV%2fv52OZIkBG%2b8jqjwmUobcjXVIC1BG9g%2fynMN0itZklL2x27Z2imCF6xELcQUuGdkoXBj%2bI%2bTlKM" }

  let(:proof) { "IflL8OWCOCmws5qnDD5kYMraMGI3o+T+hojoDREbjZSkxbbx7XIS1Av85lohPKjyksocpeVwqEYm9nVWfnq05uhDNGp2MsNyhPO9unZ6w25Rjs1hDFM0dmvYx8wlQBNZ/CFPaz3inCMaaP4PtU85YepaDccAjNc1gikdy3kSMeG1XZuaDixHvMKzF/60DMfLMBIu5xP4Nt8i8Gi2oZs4REuxi6yxOv2vQJQ5+8Wu2Olm8qZvT4FEIQT9oZAXebn/CxyvyQv+RVpoU2gb4BreXAdfKthWF67GpJyhr+ibEVDoIIolUvviycyEtjsaEBpOf6Ne/OLRNu98un7WNDzMTQ==" }
  let(:old_proof) { "lWBTpWW8q80WC1eJEH5HMnGka4/LUF7zjUPqBwRMO0JzVcnjICvMP2TZPB2lJfy/4ctIstCN6P1t38NCTTbLWlXuE+c4jqL9r2HPAdPPcPYiBAE1Evww93GpxVyOVcGADffshQvfaYFCfwL9vrBRstaQuWI0N5QlBCtWbnObF4dFsFWRRSZVU0X9YcNGhVX1NkVFVfCKG63Q/JkL+TnsJ7zqb7ZQpbS19tYyy4abtlGKWm3Zc1Jq9hPI3XVpoARXEO8cW6lT932QGdZiNr9aW2c15zTC6WiTxVeu7RW2Y0meX+Sfyrfu7GFb5JXDJAq8ZrUEUWABv1BOhHz5vLYHIA==" }

  let(:params) { { 'access_token' => access_token } }
  let(:env) { {
    'HTTP_X_WOPI_PROOF' => proof,
    'HTTP_X_WOPI_PROOFOLD' => old_proof,
    'HTTP_X_WOPI_TIMESTAMP' => timestamp
  } }

  let(:request) { double(:request, params: params, env: env, url: url) }

  before do
    Timecop.freeze(Time.parse('2015-04-25 23:26:01 +0300'))
    allow(Wopinator::HTTPClient).to receive(:get).once.with(subject.send(:discovery).url).and_return(response)
  end

  after do
    Timecop.return
  end

  context '.valid?' do
    it 'should indicate that the request is valid' do
      expect(subject.valid?).to be_truthy
    end
  end
end
