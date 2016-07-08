RSpec.describe Wopinator::Request do
  subject { described_class.new(request, env: :test) }
  let(:response) { double(:response, code: 200, body: File.read(DISCOVERY_XML_FILE)) }

  let(:access_token) { "yZhdN1qgywcOQWhyEMVpB6NE3pvBksvcLXsrFKXNtBeDTPW%2fu62g2t%2fOCWSlb3jUGaz1zc%2fzOzbNgAredLdhQI1Q7sPPqUv2owO78olmN74DV%2fv52OZIkBG%2b8jqjwmUobcjXVIC1BG9g%2fynMN0itZklL2x27Z2imCF6xELcQUuGdkoXBj%2bI%2bTlKM" }
  let(:timestamp) { '635655897610773532' }
  let(:url) { "https://contoso.com/wopi/files/vHxYyRGM8VfmSGwGYDBMIQPzuE+sSC6kw+zWZw2Nyg?access_token=yZhdN1qgywcOQWhyEMVpB6NE3pvBksvcLXsrFKXNtBeDTPW%2fu62g2t%2fOCWSlb3jUGaz1zc%2fzOzbNgAredLdhQI1Q7sPPqUv2owO78olmN74DV%2fv52OZIkBG%2b8jqjwmUobcjXVIC1BG9g%2fynMN0itZklL2x27Z2imCF6xELcQUuGdkoXBj%2bI%2bTlKM" }

  let(:proof) { "IflL8OWCOCmws5qnDD5kYMraMGI3o+T+hojoDREbjZSkxbbx7XIS1Av85lohPKjyksocpeVwqEYm9nVWfnq05uhDNGp2MsNyhPO9unZ6w25Rjs1hDFM0dmvYx8wlQBNZ/CFPaz3inCMaaP4PtU85YepaDccAjNc1gikdy3kSMeG1XZuaDixHvMKzF/60DMfLMBIu5xP4Nt8i8Gi2oZs4REuxi6yxOv2vQJQ5+8Wu2Olm8qZvT4FEIQT9oZAXebn/CxyvyQv+RVpoU2gb4BreXAdfKthWF67GpJyhr+ibEVDoIIolUvviycyEtjsaEBpOf6Ne/OLRNu98un7WNDzMTQ==" }
  let(:old_proof) { "lWBTpWW8q80WC1eJEH5HMnGka4/LUF7zjUPqBwRMO0JzVcnjICvMP2TZPB2lJfy/4ctIstCN6P1t38NCTTbLWlXuE+c4jqL9r2HPAdPPcPYiBAE1Evww93GpxVyOVcGADffshQvfaYFCfwL9vrBRstaQuWI0N5QlBCtWbnObF4dFsFWRRSZVU0X9YcNGhVX1NkVFVfCKG63Q/JkL+TnsJ7zqb7ZQpbS19tYyy4abtlGKWm3Zc1Jq9hPI3XVpoARXEO8cW6lT932QGdZiNr9aW2c15zTC6WiTxVeu7RW2Y0meX+Sfyrfu7GFb5JXDJAq8ZrUEUWABv1BOhHz5vLYHIA==" }

  let(:default_env) { {
    'HTTP_X_WOPI_PROOF' => proof,
    'HTTP_X_WOPI_PROOFOLD' => old_proof,
    'HTTP_X_WOPI_TIMESTAMP' => timestamp,
    'REQUEST_PATH' => '/wopi/files/vHxYyRGM8VfmSGwGYDBMIQPzuE+sSC6kw+zWZw2Nyg',
    'REQUEST_METHOD' => 'GET'
  } }

  let(:params) { { 'access_token' => access_token } }
  let(:env) { default_env }

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

  context '.method' do
    it 'should return method' do
      expect(subject.method).to eql(:get)
    end
  end

  context '.lock' do
    let(:env) { default_env.merge('HTTP_X_WOPI_LOCK' => 'lock', 'HTTP_X_WOPI_OLDLOCK' => 'oldlock') }

    it 'should return lock' do
      lock = subject.lock

      expect(lock).to be_an(Wopinator::Lock)
      expect(lock.id).to eql('lock')
      expect(lock.old_id).to eql('oldlock')
      expect(lock.expired?).to be_falsy
    end
  end

  context '.headers' do
    it 'should return headers' do
      headers = subject.headers

      expect(headers).to be_an(Wopinator::Headers)
      expect(headers.count).to eql(3)
      expect(headers.get(:proof)).to eql(proof)
      expect(headers.get(:proofold)).to eql(old_proof)
      expect(headers.get(:timestamp)).to eql(timestamp)
    end
  end

  context '.action' do
    context 'without override and without contents path' do
      it 'should return get file info' do
        expect(subject.action).to eql(:get_file_info)
      end
    end

    context 'without override but with contents path' do
      let(:env_with_contents_path) do
        default_env.merge(
          'REQUEST_PATH' => '/wopi/files/vHxYyRGM8VfmSGwGYDBMIQPzuE+sSC6kw+zWZw2Nyg/contents'
        )
      end

      context 'when method is get' do
        let(:env) { env_with_contents_path }

        it 'should return get file' do
          expect(subject.action).to eql(:get_file)
        end
      end

      context 'when method is post' do
        let(:env) { env_with_contents_path.merge('REQUEST_METHOD' => 'POST') }
        
        it 'should return put file' do
          expect(subject.action).to eql(:put_file)
        end
      end
    end

    context 'with override' do
      context 'when put relative'  do
        let(:env) { default_env.merge('HTTP_X_WOPI_OVERRIDE' => 'PUT_RELATIVE') }

        it 'should return put relative file' do
          expect(subject.action).to eql(:put_relative_file)
        end
      end

      context 'when put' do
        let(:env) { default_env.merge('HTTP_X_WOPI_OVERRIDE' => 'PUT') }

        it 'should return put file' do
          expect(subject.action).to eql(:put_file)
        end
      end

      context 'when lock' do
        let(:env) { default_env.merge('HTTP_X_WOPI_OVERRIDE' => 'LOCK') }

        it 'should return lock' do
          expect(subject.action).to eql(:lock)
        end
      end

      context 'when lock with old lock id' do
        let(:env) { default_env.merge('HTTP_X_WOPI_OVERRIDE' => 'LOCK', 'HTTP_X_WOPI_OLDLOCK' => 'oldlock') }

        it 'should return unlock and relock' do
          expect(subject.action).to eql(:unlock_and_relock)
        end
      end

      context 'when refresh lock' do
        let(:env) { default_env.merge('HTTP_X_WOPI_OVERRIDE' => 'REFRESH_LOCK') }

        it 'should return refresh lock' do
          expect(subject.action).to eql(:refresh_lock)
        end
      end

      context 'when unlock' do
        let(:env) { default_env.merge('HTTP_X_WOPI_OVERRIDE' => 'UNLOCK') }

        it 'should return unlock' do
          expect(subject.action).to eql(:unlock)
        end
      end
    end
  end
end
