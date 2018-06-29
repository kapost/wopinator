require 'wopinator/timestamp'

module Wopinator
  class Signature
    attr_reader :access_token, :timestamp, :url

    def initialize(access_token, timestamp, url)
      self.access_token = access_token
      self.timestamp = Timestamp.new(timestamp)
      self.url = url
    end

    def to_s
      # Pack bytes as unsigned chars and then base 64 encode the result
      [bytes.pack('C*')].pack('m*')
    end

    def bytes
      # WOPI timestamps are 64 bit (big-endian) long ints
      # Ruby has no *pack* format to allow this by default, so we just pack it
      # and then reverse the bytes manually, thus obtaining the desired result
      timestamp_bytes = [timestamp.to_i].pack('Q').bytes.reverse # 64 bit big-endian

      bytes = []
      bytes += [access_token.length].pack('N').bytes # 32 bit big-endian
      bytes += access_token.bytes

      bytes += [url.length].pack('N').bytes # 32 bit big-endian
      bytes += url.upcase.bytes

      bytes += [timestamp_bytes.length].pack('N').bytes # 32 bit-big endian
      bytes += timestamp_bytes

      bytes
    end

    def verify(proof, old_proof, proof_key, old_proof_key)
      return false if timestamp.older_than_twenty_minutes?

      proof_key.verify(proof, self) ||
      proof_key.verify(old_proof, self) ||
      old_proof_key.verify(proof, self)
    end

    private

    attr_writer :access_token, :url, :timestamp
  end
end
