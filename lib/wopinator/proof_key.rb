require 'base64'
require 'openssl'

module Wopinator
  class ProofKey
    attr_reader :value, :modulus, :exponent

    def initialize(value, modulus, exponent)
      self.value = value
      # MSZ: document this
      self.modulus = Base64.decode64(modulus).unpack('H*')[0].to_i(16)
      self.exponent = Base64.decode64(exponent).unpack('H*')[0].to_i(16)
    end

    def verify(signature, expected_signature)
      digest = OpenSSL::Digest::SHA256.new
      public_key.verify(digest, Base64.decode64(signature.to_s), expected_signature.to_s)
    end

    private

    attr_writer :value, :modulus, :exponent

    def public_key
      @_public_key ||= OpenSSL::PKey::RSA.new.tap do |key|
        key.n = OpenSSL::BN.new(modulus)
        key.e = OpenSSL::BN.new(exponent)
      end
    end
  end
end
