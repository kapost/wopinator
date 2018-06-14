require 'openssl'

module Wopinator
  class ProofKey
    attr_reader :value, :modulus, :exponent

    def initialize(value, modulus, exponent)
      self.value = value
      self.modulus = convert(modulus)
      self.exponent = convert(exponent)
    end

    def verify(signature, expected_signature)
      # We verify the two signatures using a SHA256 digest. Both signatures are
      # base 64 encoded and need to be decoded before the verification can happen
      digest = OpenSSL::Digest::SHA256.new
      public_key.verify(digest, decode64(signature), decode64(expected_signature))
    end

    private

    attr_writer :value, :modulus, :exponent

    def convert(value)
      # The modulus and the exponent of the RSA key are base 64 encoded
      # strings containing hexadecimal values with their most significant
      # bit stored first (big endian)
      decode64(value).unpack('H*')[0].to_i(16)
    end

    def decode64(value)
      value.to_s.unpack('m*')[0]
    end

    def public_key
      # In order to reconstruct the RSA public key we use the modulus and exponent
      # since there is no way to import the base 64 encoded binary blob
      @_public_key ||= OpenSSL::PKey::RSA.new.tap do |key|
        set_key(key, OpenSSL::BN.new(modulus), OpenSSL::BN.new(exponent))
      end
    end

    def set_key(key, n, e)
      if key.respond_to?(:set_key) # ruby >= "2.4.3"
        key.set_key(n, e, nil)
      else
        key.n = n
        key.e = e
      end
    end
  end
end
