module Wopinator
  class Signature
    attr_reader :access_token, :url, :timestamp

    def initialize(access_token, url, timestamp)
      self.access_token = access_token
      self.url = url
      self.timestamp = timestamp.to_i
    end

    def to_s
      bytes.pack('C*')
    end

    def bytes
      # MSZ: document this *magic*
      timestamp_bytes = [timestamp].pack('Q').bytes.reverse # 64 bit big-endian

      bytes = []
      bytes += [access_token.length].pack('N').bytes # 32 bit big-endian
      bytes += access_token.bytes

      bytes += [url.length].pack('N').bytes # 32 bit big-endian
      bytes += url.upcase.bytes

      bytes += [timestamp_bytes.length].pack('N').bytes # 32 bit-big endian
      bytes += timestamp_bytes

      bytes
    end

    private

    attr_writer :access_token, :url, :timestamp
  end
end
