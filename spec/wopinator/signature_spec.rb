RSpec.describe Wopinator::Signature do
  subject { described_class.new(access_token, timestamp, url) }

  let(:value) { "BgIAAACkAABSU0ExAAgAAAEAAQDFEthb5dkE+fGnJgsmY3IXmoFxj1cOwVYLpLNTEksnVRzbXcPfaSl/kFxn5b4QajhH1sTtXECZY6ZUyiDi1NG5ukFc9Fppgt0ywnuJqNBRWPfvLTOaVZRTtr8X8hqL+dPldOI3qFUW2zF6DEsAO9y74l3s6MqNjawCME5X0jb28TOrbXXsDfIGLEN3VBFO3wyhlRZKOmR9ZiqxQbpOz0Ltgv3HYci9OVN9c8YYV5T+fHI0Wtxg4F9lJHlB6MHPV9seVqr4ieM027NG89LhHm9BJEtceII09JgmkwLFUB/s2YGirUwZewk0efw1GL861PE7Vjdn2bIdmGSCRfFQlnPQ" }
  let(:modulus) { "0HOWUPFFgmSYHbLZZzdWO/HUOr8YNfx5NAl7GUytooHZ7B9QxQKTJpj0NIJ4XEskQW8e4dLzRrPbNOOJ+KpWHttXz8HoQXkkZV/gYNxaNHJ8/pRXGMZzfVM5vchhx/2C7ULPTrpBsSpmfWQ6ShaVoQzfThFUd0MsBvIN7HVtqzPx9jbSV04wAqyNjcro7F3iu9w7AEsMejHbFlWoN+J05dP5ixryF7+2U5RVmjMt7/dYUdCoiXvCMt2CaVr0XEG6udHU4iDKVKZjmUBc7cTWRzhqEL7lZ1yQfylp38Nd2xxVJ0sSU7OkC1bBDlePcYGaF3JjJgsmp/H5BNnlW9gSxQ==" }
  let(:exponent) { "AQAB" }

  let(:old_value) { "BgIAAACkAABSU0ExAAgAAAEAAQClucwAqDjPvK3/nrmf51f8tsDkBeuCQnz8qYn66hftzDfzn2zR8RlGDXfm3wKsTBwDDzL2QXsJm09c9/p8FpPi39lpM31dfO/7KyqbQ4x/lfa9Y6SyPIP2eG/tKrXbkeIoWfyCtuQqeY6HrmijYOKc6IN4WOJWaWl2etVu8FRnk2plvlEHLm0N8x5ytCSCd776XXHmY7UzMiR0p6IGLpVfKM0ulQY65bmCGvDxkZwSOJyDV/hkQDGluMRLqQHrSAbnAn+ZKh3NTNspveigbUkakPIX8wc2I8ztzjvXXOp3KPzNFfQQGjLMo51CILxH6pRUvb4q8+VDijfiWvdvafq7" }
  let(:old_modulus) { "u/ppb/da4jeKQ+XzKr69VJTqR7wgQp2jzDIaEPQVzfwod+pc1zvO7cwjNgfzF/KQGkltoOi9KdtMzR0qmX8C5wZI6wGpS8S4pTFAZPhXg5w4EpyR8fAagrnlOgaVLs0oX5UuBqKndCQyM7Vj5nFd+r53giS0ch7zDW0uB1G+ZWqTZ1TwbtV6dmlpVuJYeIPonOJgo2iuh455KuS2gvxZKOKR27Uq7W949oM8sqRjvfaVf4xDmyor++98XX0zadnf4pMWfPr3XE+bCXtB9jIPAxxMrALf5ncNRhnx0Wyf8zfM7Rfq+omp/HxCgusF5MC2/Ffnn7me/628zzioAMy5pQ==" }
  let(:old_exponent) { "AQAB" }

  let(:signature) { "IflL8OWCOCmws5qnDD5kYMraMGI3o+T+hojoDREbjZSkxbbx7XIS1Av85lohPKjyksocpeVwqEYm9nVWfnq05uhDNGp2MsNyhPO9unZ6w25Rjs1hDFM0dmvYx8wlQBNZ/CFPaz3inCMaaP4PtU85YepaDccAjNc1gikdy3kSMeG1XZuaDixHvMKzF/60DMfLMBIu5xP4Nt8i8Gi2oZs4REuxi6yxOv2vQJQ5+8Wu2Olm8qZvT4FEIQT9oZAXebn/CxyvyQv+RVpoU2gb4BreXAdfKthWF67GpJyhr+ibEVDoIIolUvviycyEtjsaEBpOf6Ne/OLRNu98un7WNDzMTQ==" }

  let(:access_token) { "yZhdN1qgywcOQWhyEMVpB6NE3pvBksvcLXsrFKXNtBeDTPW%2fu62g2t%2fOCWSlb3jUGaz1zc%2fzOzbNgAredLdhQI1Q7sPPqUv2owO78olmN74DV%2fv52OZIkBG%2b8jqjwmUobcjXVIC1BG9g%2fynMN0itZklL2x27Z2imCF6xELcQUuGdkoXBj%2bI%2bTlKM" }
  let(:timestamp) { 635655897610773532 }
  let(:url) { "https://contoso.com/wopi/files/vHxYyRGM8VfmSGwGYDBMIQPzuE+sSC6kw+zWZw2Nyg?access_token=yZhdN1qgywcOQWhyEMVpB6NE3pvBksvcLXsrFKXNtBeDTPW%2fu62g2t%2fOCWSlb3jUGaz1zc%2fzOzbNgAredLdhQI1Q7sPPqUv2owO78olmN74DV%2fv52OZIkBG%2b8jqjwmUobcjXVIC1BG9g%2fynMN0itZklL2x27Z2imCF6xELcQUuGdkoXBj%2bI%2bTlKM" }

  let(:expected_signature_human) {
    s = <<-HUMAN
AAAAyHlaaGROMXFneXdjT1FXaHlFTVZwQjZORTNwdkJrc3ZjTFhzckZLWE50
QmVEVFBXJTJmdTYyZzJ0JTJmT0NXU2xiM2pVR2F6MXpjJTJmek96Yk5nQXJl
ZExkaFFJMVE3c1BQcVV2Mm93Tzc4b2xtTjc0RFYlMmZ2NTJPWklrQkclMmI4
anFqd21Vb2JjalhWSUMxQkc5ZyUyZnluTU4waXRaa2xMMngyN1oyaW1DRjZ4
RUxjUVV1R2Rrb1hCaiUyYkklMmJUbEtNAAABH0hUVFBTOi8vQ09OVE9TTy5D
T00vV09QSS9GSUxFUy9WSFhZWVJHTThWRk1TR1dHWURCTUlRUFpVRStTU0M2
S1crWldaVzJOWUc/QUNDRVNTX1RPS0VOPVlaSEROMVFHWVdDT1FXSFlFTVZQ
QjZORTNQVkJLU1ZDTFhTUkZLWE5UQkVEVFBXJTJGVTYyRzJUJTJGT0NXU0xC
M0pVR0FaMVpDJTJGWk9aQk5HQVJFRExESFFJMVE3U1BQUVVWMk9XTzc4T0xN
Tjc0RFYlMkZWNTJPWklLQkclMkI4SlFKV01VT0JDSlhWSUMxQkc5RyUyRllO
TU4wSVRaS0xMMlgyN1oySU1DRjZYRUxDUVVVR0RLT1hCSiUyQkklMkJUTEtN
AAAACAjSTavIeOQc
HUMAN
  }
  let(:expected_signature_bytes) { [0, 0, 0, 200, 121, 90, 104, 100, 78, 49, 113, 103, 121, 119, 99, 79, 81, 87, 104, 121, 69, 77, 86, 112, 66, 54, 78, 69, 51, 112, 118, 66, 107, 115, 118, 99, 76, 88, 115, 114, 70, 75, 88, 78, 116, 66, 101, 68, 84, 80, 87, 37, 50, 102, 117, 54, 50, 103, 50, 116, 37, 50, 102, 79, 67, 87, 83, 108, 98, 51, 106, 85, 71, 97, 122, 49, 122, 99, 37, 50, 102, 122, 79, 122, 98, 78, 103, 65, 114, 101, 100, 76, 100, 104, 81, 73, 49, 81, 55, 115, 80, 80, 113, 85, 118, 50, 111, 119, 79, 55, 56, 111, 108, 109, 78, 55, 52, 68, 86, 37, 50, 102, 118, 53, 50, 79, 90, 73, 107, 66, 71, 37, 50, 98, 56, 106, 113, 106, 119, 109, 85, 111, 98, 99, 106, 88, 86, 73, 67, 49, 66, 71, 57, 103, 37, 50, 102, 121, 110, 77, 78, 48, 105, 116, 90, 107, 108, 76, 50, 120, 50, 55, 90, 50, 105, 109, 67, 70, 54, 120, 69, 76, 99, 81, 85, 117, 71, 100, 107, 111, 88, 66, 106, 37, 50, 98, 73, 37, 50, 98, 84, 108, 75, 77, 0, 0, 1, 31, 72, 84, 84, 80, 83, 58, 47, 47, 67, 79, 78, 84, 79, 83, 79, 46, 67, 79, 77, 47, 87, 79, 80, 73, 47, 70, 73, 76, 69, 83, 47, 86, 72, 88, 89, 89, 82, 71, 77, 56, 86, 70, 77, 83, 71, 87, 71, 89, 68, 66, 77, 73, 81, 80, 90, 85, 69, 43, 83, 83, 67, 54, 75, 87, 43, 90, 87, 90, 87, 50, 78, 89, 71, 63, 65, 67, 67, 69, 83, 83, 95, 84, 79, 75, 69, 78, 61, 89, 90, 72, 68, 78, 49, 81, 71, 89, 87, 67, 79, 81, 87, 72, 89, 69, 77, 86, 80, 66, 54, 78, 69, 51, 80, 86, 66, 75, 83, 86, 67, 76, 88, 83, 82, 70, 75, 88, 78, 84, 66, 69, 68, 84, 80, 87, 37, 50, 70, 85, 54, 50, 71, 50, 84, 37, 50, 70, 79, 67, 87, 83, 76, 66, 51, 74, 85, 71, 65, 90, 49, 90, 67, 37, 50, 70, 90, 79, 90, 66, 78, 71, 65, 82, 69, 68, 76, 68, 72, 81, 73, 49, 81, 55, 83, 80, 80, 81, 85, 86, 50, 79, 87, 79, 55, 56, 79, 76, 77, 78, 55, 52, 68, 86, 37, 50, 70, 86, 53, 50, 79, 90, 73, 75, 66, 71, 37, 50, 66, 56, 74, 81, 74, 87, 77, 85, 79, 66, 67, 74, 88, 86, 73, 67, 49, 66, 71, 57, 71, 37, 50, 70, 89, 78, 77, 78, 48, 73, 84, 90, 75, 76, 76, 50, 88, 50, 55, 90, 50, 73, 77, 67, 70, 54, 88, 69, 76, 67, 81, 85, 85, 71, 68, 75, 79, 88, 66, 74, 37, 50, 66, 73, 37, 50, 66, 84, 76, 75, 77, 0, 0, 0, 8, 8, 210, 77, 171, 200, 120, 228, 28] }

  before do
    Timecop.freeze(Time.parse('2015-04-25 23:26:01 +0300'))
  end

  after do
    Timecop.return
  end

  context '.to_s' do
    it 'should return the signature in a human readable base 64 encoded format' do
      expect(subject.to_s).to eql(expected_signature_human)
    end
  end

  context '.bytes' do
    it 'should return the signature as bytes' do
      expect(subject.bytes).to eql(expected_signature_bytes)
    end
  end

  context '.verify' do
    let(:proof_key) {  Wopinator::ProofKey.new(value, modulus, exponent) }
    let(:old_proof_key) { Wopinator::ProofKey.new(old_value, old_modulus, old_exponent) }

    let(:signatures) { [[true, described_class.new("yZhdN1qgywcOQWhyEMVpB6NE3pvBksvcLXsrFKXNtBeDTPW%2fu62g2t%2fOCWSlb3jUGaz1zc%2fzOzbNgAredLdhQI1Q7sPPqUv2owO78olmN74DV%2fv52OZIkBG%2b8jqjwmUobcjXVIC1BG9g%2fynMN0itZklL2x27Z2imCF6xELcQUuGdkoXBj%2bI%2bTlKM", 635655897610773532, "https://contoso.com/wopi/files/vHxYyRGM8VfmSGwGYDBMIQPzuE+sSC6kw+zWZw2Nyg?access_token=yZhdN1qgywcOQWhyEMVpB6NE3pvBksvcLXsrFKXNtBeDTPW%2fu62g2t%2fOCWSlb3jUGaz1zc%2fzOzbNgAredLdhQI1Q7sPPqUv2owO78olmN74DV%2fv52OZIkBG%2b8jqjwmUobcjXVIC1BG9g%2fynMN0itZklL2x27Z2imCF6xELcQUuGdkoXBj%2bI%2bTlKM"),
        ["IflL8OWCOCmws5qnDD5kYMraMGI3o+T+hojoDREbjZSkxbbx7XIS1Av85lohPKjyksocpeVwqEYm9nVWfnq05uhDNGp2MsNyhPO9unZ6w25Rjs1hDFM0dmvYx8wlQBNZ/CFPaz3inCMaaP4PtU85YepaDccAjNc1gikdy3kSMeG1XZuaDixHvMKzF/60DMfLMBIu5xP4Nt8i8Gi2oZs4REuxi6yxOv2vQJQ5+8Wu2Olm8qZvT4FEIQT9oZAXebn/CxyvyQv+RVpoU2gb4BreXAdfKthWF67GpJyhr+ibEVDoIIolUvviycyEtjsaEBpOf6Ne/OLRNu98un7WNDzMTQ==", "lWBTpWW8q80WC1eJEH5HMnGka4/LUF7zjUPqBwRMO0JzVcnjICvMP2TZPB2lJfy/4ctIstCN6P1t38NCTTbLWlXuE+c4jqL9r2HPAdPPcPYiBAE1Evww93GpxVyOVcGADffshQvfaYFCfwL9vrBRstaQuWI0N5QlBCtWbnObF4dFsFWRRSZVU0X9YcNGhVX1NkVFVfCKG63Q/JkL+TnsJ7zqb7ZQpbS19tYyy4abtlGKWm3Zc1Jq9hPI3XVpoARXEO8cW6lT932QGdZiNr9aW2c15zTC6WiTxVeu7RW2Y0meX+Sfyrfu7GFb5JXDJAq8ZrUEUWABv1BOhHz5vLYHIA=="]],
        [true, described_class.new("RLoY%2f3D73%2fjwt6IQqR1wHqCEKDxRf2v0GPDa0ZHTlA6ik1%2fNBHDD6bHCI0BQrvacjNBL8ok%2fZsVPI%2beAIA5mHSOUbhW9ohowwD6Ljlwro2n5PkTBh6GEYi2afuCIQ8mjXAUdvEDg3um2GjJKtA%3d%3d", 635655897361394523, "https://contoso.com/wopi/files/JIB9h+LJpZWBDwvoIiQ5p3115zJWDecpGF9aCm1vOa5UMllgC7w?access_token=RLoY%2f3D73%2fjwt6IQqR1wHqCEKDxRf2v0GPDa0ZHTlA6ik1%2fNBHDD6bHCI0BQrvacjNBL8ok%2fZsVPI%2beAIA5mHSOUbhW9ohowwD6Ljlwro2n5PkTBh6GEYi2afuCIQ8mjXAUdvEDg3um2GjJKtA%3d%3d"),
        ["x0IeSOjUQNH2pvjMPkP4Jotzs5Weeqms4AlPxMQ5CipssUJbyKFjLWnwPg1Ac0XtSTiPD177BmQ1+KtmYvDTWQ1FmBuvpvKZDSKzXoT6Qj4LCYYQ0TxnN/OT231+qd50sOD8zAxhfXP56qND9tj5xqoHMa+lbuvNCqiOBTZw5f/dklSK7Wgdx7ST3Dq6S9xxDUfsLC4Tjq+EsvcdSNIWL/W6NRZdyWqlgRgE6X8t/2iyyMypURdOW2Rztc6w/iYhbuh22Ul6Jfu14KaDo6YkvBr8iHlK4CcQST9i0u044y1Jnh34UK4EPdVRZrvTmeJ/5DFLWOqEwvBlW2bpoYF+9A==", "etYRI9UT6q8jA6PHMMmuGa8NbyIlbTHMHmJZqaCOh2GCpv7um2q7+7oaDFqAV/UP+2N85yZXvZgt9kTOUCwIdggUQVeJluNCwf1B5NsN/7n2aQF9LnWyYK8kK/3xvQKQrj4n24jk2MnHcX1tk8H/qLxq2DbPzi6ROoSgs2ZK8nmzhSPF74jnLCrwiwGgnVZV6gIhlAKCcUGtdrT60sgD/wpJGQQ0M59VDQhf1aDj5bUotf8RXovY8Gl0lpguvN4+EsEjpbVjdV9hxWs7c03JDdoz7mzFUWErSly9IzYXNfuFZMnSXpF3lGiprVJvW34Bu2gTo/cLq4LQoABkNCmd4g=="]],
        [true, described_class.new("zo7pjAbo%2fyof%2bvtUJn5gXpYcSl7TSSx0TbQGJbWJSll9PTjRRsAbG%2fSNL7FM2n5Ei3jQ8UJsW4RidT5R4tl1lrCi1%2bhGjxfWAC9pRRl6J3M1wZk9uFkWEeGzbtGByTkaGJkBqgKV%2ffxg%2bvATAhVr6E3LHCBAN91Wi8UG", 635655898374047766, "https://contoso.com/wopi/files/RVQ29k8tf3h8cJ/Endy+aAMPy0iGhLatGNrhvKofPY9p2w?access_token=zo7pjAbo%2fyof%2bvtUJn5gXpYcSl7TSSx0TbQGJbWJSll9PTjRRsAbG%2fSNL7FM2n5Ei3jQ8UJsW4RidT5R4tl1lrCi1%2bhGjxfWAC9pRRl6J3M1wZk9uFkWEeGzbtGByTkaGJkBqgKV%2ffxg%2bvATAhVr6E3LHCBAN91Wi8UG"),
        ["qQhMjQf9Zohj+S/wvhe+RD6W5TIEqJwDWO3zX9DB85yRe3Ide7EPQDCY9dAZtJpWkIDDzU+8FEwnexF0EhPimfCkmAyoPpkl2YYvQvvwUK2gdlk3WboWOVszm17p4dSDA0TDMPYsjaAGHKM/nPnTyIMzRyArEzoy2vNkLEP6qdBIuMP2aCtGsciwMjYifHYRIRenB7H7I+FkwH0UaoTUCoo2PJkyZjy1nK6OwGVWaWG0G8g7Zy+K3bRYV+7cNaM5SB720ezhmYYJJvsIdRvO7pLsjAuTo4KJhvmVFCipwyCdllVHY83GjuGOsAbHIIohl0Ttq59o0jp4w2wUs8U+mQ==", "PjKR1BTNNnfOrUzfo27cLIhlrbSiOVZaANadDyHxKij/77ZYId+liyXoawvvQQPgnBH1dW6jqpr6fh5ZxZ9IOtaV+cTSUGnGdRSn7FyKs1ClpApKsZBO/iRBLXw3HDWOLc0jnA2bnxY8yqbEPmH5IBC9taYzxnf7aGjc6AWFHfs6AEQ8lMio6UoASNzjy3VVNzUX+CK+e5Z45coT0X60mjaJmidGfPdWIfyUw8sSuUwxQa1uNXAd8IceRUL7j5s9/kk7EwsihCw1Y3L+XJGG5zMsGhM9bTK5mvxj30UdmZORouNHdywOfdHaB1iOeKOk+yvWFMW3JsYShWbUhZUOEQ=="]],
        [true, described_class.new("2rZvm60097vFfXK01cylEhaYU26CbpsoEdVdk%2fDK2JzBjg185nE69CCklY36u2Thrx9DyLdNZGsbRorX12TK%2b6XW8ka%2fKSukXl9N3dkOLlZxe%2bTQhhDlcymhYZ%2fnYx282ZrnI8gdIob0nmlYAIaSDRg0ZVx%2f%2bnSV8X8cHsiMvftBkQQ%2bJgqOU1le3OimjHOiDg%3d%3d", 635655899172093398, "https://contoso.com/wopi/files/s/3BPN8mUjJJAQS+aOFtFm6CU+YNpRICIR2M7mQLeQ90BA?access_token=2rZvm60097vFfXK01cylEhaYU26CbpsoEdVdk%2fDK2JzBjg185nE69CCklY36u2Thrx9DyLdNZGsbRorX12TK%2b6XW8ka%2fKSukXl9N3dkOLlZxe%2bTQhhDlcymhYZ%2fnYx282ZrnI8gdIob0nmlYAIaSDRg0ZVx%2f%2bnSV8X8cHsiMvftBkQQ%2bJgqOU1le3OimjHOiDg%3d%3d"),
        ["nLwR4nbFq8F/RLuAQ0Yby/avSJcpktZh+JlWonkXuVunTw+BZ+F84c3i1+0o7QoPQRkYmy/HEYhFoYVghkhQJzFXf98sYxb52SvDz/pl3G/gTgCcdcqkfRSMtaslkRX1VKC3YX42ksIL0LzM4wiCOJfT70i+2Yr5EQRWi6b2JELrAqPuNkxpuUUZ3DtEXsO9r6a4WkEwJesmqcqaQpMUvQ6cAkShgY7p0gAQeL//GG6wSpDaaA3QqKBcmBgzAatCaqg9NXiPjviZdoHgnbIRjBEhtH/WG00py/tsGMoIh6R9VfnC4jEWWymB5mIiXxW1gBuL63QvQqiL1S8FQ2Xo+g==", "M7R/iGyWInpWKl1+aAPuB2yVAwWaHTi504c87V0p35PzDyTh+K6fn20ygKmxf9suN9pq+/rMtUXhvM/zCyam0dZFuWpFOI22U0AjQxIJ4ZBH+zT+e/QeNmS7w4ctxUnDJ0zGsJ/DxaC0/DAkiIMOfXgb8FMPA/Z/HY+e1C6rRsoMXy0XGoTwzIDiI6wzPVr6FJpkktwO+eCNMyxnAODhlK+nubIhvmVEzWtenMXX8a2eJ3mFquNC7Le6shiUxZA03MgqknwjasNaGPrdpJYjxCwzH3LnHPOHxVY2HcjjTQTNHO8HEPCoSw9bi5a7XFS2loQM/tm0WknBe9+q4fpMMw=="]],
        [true, described_class.new("pbocsujrb9BafFujWh%2fuh7Y6S5nBnonddEzDzV0zEFrBwhiu5lzjXRezXDC9N4acvJeGVB5CWAcxPz6cJ6FzJmwA4ZgGP6FaV%2b6CDkJYID3FJhHFrbw8f2kRfaceRjV1PzXEvFXulnz2K%2fwwv0rF2B4A1wGQrnmwxGIv9cL5PBC4", 635655898062751632, "https://contoso.com/wopi/files/DJNj59eQlM6BvwzAHkykiB1vNOWRuxT487+guv3v7HexfA?access_token=pbocsujrb9BafFujWh%2fuh7Y6S5nBnonddEzDzV0zEFrBwhiu5lzjXRezXDC9N4acvJeGVB5CWAcxPz6cJ6FzJmwA4ZgGP6FaV%2b6CDkJYID3FJhHFrbw8f2kRfaceRjV1PzXEvFXulnz2K%2fwwv0rF2B4A1wGQrnmwxGIv9cL5PBC4"),
        ["qF15pAAnOATqpUTLHIS/Z5K7OYFVjWcgKGbHPa0eHRayXsb6JKTelGQhvs74gEFgg1mIgcCORwAtMzLmEFmOHgrdvkGvRzT3jtVVtwkxEhQt8aQL20N0Nwn4wNah0HeBHskdvmA1G/qcaFp8uTgHpRYFoBaSHEP3AZVNFg5y2jyYR34nNj359gktc2ZyLel3J3j7XtyjpRPHvvYVQfh7RsArLQ0VGp8sL4/BDHdSsUyJ8FXe67TSrz6TMZPwhEUR8dYHYek9qbQjC+wxPpo3G/yusucm1gHo0BjW/l36cI8FRmNs1Fqaeppxqu31FhR8dEl7w5dwefa9wOUKcChF6A==", "KmYzHJ9tu4SXfoiWzOkUIc0Bh8H3eJrA3OnDSbu2hT68EuLTp2vmvvFcHyHIiO8DuKj7u13MxkpuUER6VSIJp3nYfm91uEE/3g61V3SzaeRXdnkcKUa5x+ulKViECL2n4mpHzNnymxojFW5Y4lKUU4qEGzjE71K1DSFTU/CBkdqycsuy/Oct8G4GhA3O4MynlCf64B9LIhlWe4G+hxZgxIO0pq7w/1SH27nvScWiljVqgOAKr0Oidk/7sEfyBcOlerLgS/A00nJYYJk23DjrKGTKz1YY0CMEsROJCMiW11caxr0aKseOYlfmb6K1RXxtmiDpJ2T4y8jintjEdzEWDA=="]],
        [true, described_class.new("%2foBUJRjT2EVSVaB0Bjl2BCC7bXkN674bwppkzj2H9Elj2G%2bVGl06EzVgv62BqIW17gZZUweK%2fBPCOWN%2bbwoHy2BWES7J4OrDgFpErCsRmRkUr982LaFC2Nxb0%2bH6u6MrWfRMK5dX6w0cltOtRU%2fnsJ9JasAq0J2%2fEzhRbQwIyMQ%3d", 635655898147049273, "https://contoso.com/wopi/files/UzfEboK8w9Eal86Vk4xzIkGwUeMAiFaNF14FfQETzQ72LPw?access_token=%2foBUJRjT2EVSVaB0Bjl2BCC7bXkN674bwppkzj2H9Elj2G%2bVGl06EzVgv62BqIW17gZZUweK%2fBPCOWN%2bbwoHy2BWES7J4OrDgFpErCsRmRkUr982LaFC2Nxb0%2bH6u6MrWfRMK5dX6w0cltOtRU%2fnsJ9JasAq0J2%2fEzhRbQwIyMQ%3d"),
        ["egEcu5FlU9q+u+d5WQ/Z1nYbttR+0iWsLh2BgiyzAq93sQFyvQ5XSCW5i/V7rt9HDewnmvIXsak5ayeoX2aDNgsVM8gSI533tO9dv/33vBM6MAzNLXP3v5rNI/TaTXcfm4Q1bIoE5RFVZUSPH73B3p1Oon0Hhhd1CysFGv6ue00CT1Dgpu/w5cVElQxZmWmguD5hEFgmg9IGKuSJ1CdVeJLcTbdKWhJnTl/G4+SpXfWBnvTBXSzLK+PdtfVCxh/bPO/FJNRWNAg+UgdVAXnLN79faiioG27lXGVrodpVgW8qdANvDkjQbn7z7jXmQmv8ksVQgHfZel963NXRty5pDg==", "AQUuboqy0JFnMgWfaz8o6V3YDCd6fwQlmkM5cNxCK1ikLK03W4R3xjazBevNja70i3y0JYZ3GvTlJy4ZsEfYf+DRhfzgSuxExpTvNB5RMUvi/kNRTlrMNm6JQrLr2rTY5A+FvQ8YErnKSl5gqh9vb4b47sRdQNvYL5hiVI+Qd4AGAwN9dSq/IJo3jHtivPSGMEfuqozoX3/GQEYfRf5dv58Rjeo5XRiDvuSDhPOacdoL/DFc/ksC0u9vN4qmoTSvt313p/FhFZ9T3NZYi/dv63XP8DJLWs3HMauzGiKFbvKaxDYb2K2llM1CRM2PbKproARMUR6oYYzwNKtg/Q7qIw=="]],
        [false, described_class.new("7DHGrfxYtgXxfaXF%2benHF3PTGMrgNlYktkbQB8q%2fn2aQwzYQ6qTmqNJRnJm5QIMXS7WbIxMy0LXaova2h687Md4%2bNTazty3P7HD3j5q9anbCuLsUJHtSXfKANUetLyAjFWq6egtMZJSHzDajO0EaHTeA9M7zJg1j69dEMoLmIbxP03kwAvBrdVQmjFdFryKw", 635655899260461032, "https://contoso.com/wopi/files/Dy07US/uXVeOMwgyEqGqeVNnyOoaRxR+es2atR08tZPMatf0gf0?access_token=7DHGrfxYtgXxfaXF%2benHF3PTGMrgNlYktkbQB8q%2fn2aQwzYQ6qTmqNJRnJm5QIMXS7WbIxMy0LXaova2h687Md4%2bNTazty3P7HD3j5q9anbCuLsUJHtSXfKANUetLyAjFWq6egtMZJSHzDajO0EaHTeA9M7zJg1j69dEMoLmIbxP03kwAvBrdVQmjFdFryKw"),
        ["Y/wVmPuvWJ5Q/Gl/a5mCkTrCKbfHWYiMG6cxmJgD+M/yYFzTsfcgbK2IRAlCR2eqGx3a5wh5bQzlC6Y/sKo2IE9Irz/NHFpV55zYfdwDi5ccwXSd34jWVUgkM3uL1r6KVmHcQH/ew10p54FVatXatuGp2Y+cq9BScYV1a45U8fs9zYoZcTAYvdWeYXmJbRGMOLLxab3fOiulPmbw+gOqpYPbuInc0yut6eGxAUmY1ENxpN7nbUqI3LbJvmE3PuX8Ifgg3RCsaFJEqC6JR36MjG+VqoKaFI6hh/ZWLR4y7FBarSmQBr2VlAHrcWCJIMXoOOKaHdsDfNCb3A24LFvdAQ==", "Pdbk1FoAB4zhxaDptfVOwTCmrNgWO6zdokoI3VYO8eshE9nJR1Rzr9K2666za29IfT050jJX0EBanIXAawL4rFA6swPHYQAzf3pWJqwvqIbaLYvi4104IBWhm9XdZ7C1jDUmG8DgwbKrXZfg7xxZ/hzPlwEp5Y9ZijD/ReAgRs0Va8/ytWc3AJ+121Q1Ss9U8vD08K5+wg1PVYyNa2YGBpVJbt2ZSt8dvuciWZujFDTzgLvRr6w17kg6+jkiwJyz2ZIL6ytyiUE1oJzsbslIZN3yGHEcmXZZ8Xz5q8fzrLUVmRx1kX6FE2QzRe4+6Q+qNeI8Ct7dj7JBBdbK2Jq+6A=="]],
        [false, described_class.new("itKqYThsIRPrrctbu%2bh7%2fMcYvNZiVKc5Un50ZqjKtvhVwz0XcObcEVm5rghR4PmrUG0P28QnQTYrcQ65%2bLtrIfbTBferY4zhPKt9qKaf6HKEyRU7utszLoIG7P7XIhmdTo0RftsCAO3gLp4ZqZiQi4icNS6mMGYboNZ1pHaNCRmR31oZjmqWgcknWow8", 635655897692506269, "https://contoso.com/wopi/files/6XZhdjvt6/cdJvXdBI1bdlIkhIjJPnb9HgWzZX7V2d8?access_token=itKqYThsIRPrrctbu%2bh7%2fMcYvNZiVKc5Un50ZqjKtvhVwz0XcObcEVm5rghR4PmrUG0P28QnQTYrcQ65%2bLtrIfbTBferY4zhPKt9qKaf6HKEyRU7utszLoIG7P7XIhmdTo0RftsCAO3gLp4ZqZiQi4icNS6mMGYboNZ1pHaNCRmR31oZjmqWgcknWow8"),
        ["Bu+myEy45g0hyKJycD7BYoDH+s10yvuH79Iq3OLz4w/o7gT8orKRrZ4KggJUWMzRPPSgg+CqEf6zdNm6kFrxf/zXCXTqa/bEzmJPNBby+r0jlyz2KFsOkxJ/mzVMKJltG0le56NJim21ZU4AwN0KiB6TZ56ruu/ma014proZWJt/H0qye/pNz5ZyYdyc1khgzKf/8o6sCgh6+VEZx93BjAUyMJr6OS9nYq1B8XGei/sE4xdgbrIGW0Jwjl2hxqBQTn1VL0jyljbjuG+vy83QaeBSB4TGLljHZFgYp6ARCX7v3NHO0MicJtTpLdpsB9dlLkbms/BcJd1gK7m5dDJK1A==", "CDU9l+cyr82vrUnyhdTh1P4jDwL82c//XrTWU/rPeTyB9Ko6z2aNCs893GEB3jICY7mDZ4t0sA5z/lpN83UyfH1uVqnEB92zCQsJTkXMdNG9dsK64G6RxIVbmhJkV5xiJvERCRnJJTcQg4ymeXQ3cuXAcN9XhStK8FCxBhxGMJsmlY2tahxdTEIHXHVagvdyB1UY0V1rv+OAOnCGaTs0yyBA0Mo5nmTSNF8VnYmqsmbXyyDPJJTsqallyJPxvdrLPeiBq1JHMr3b8dgel1jfweDR4mD9pHn3O9eaHN8b6xlLc+dIpwvcflzyhhEL5JKEUtO6EKbfakZTUeS86BuBZA=="]]]
    }

    it 'should verify the signature' do
      signatures.each do |(result, signature, new_old_signature)|
        expect(signature.verify(*new_old_signature, proof_key, old_proof_key)).to eql(result)
      end
    end
  end
end
