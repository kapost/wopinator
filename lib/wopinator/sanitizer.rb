module Wopinator
  class Sanitizer
    class << self
      def sanitize(s)
        s.gsub(/[^a-zA-Z0-9\.\-\_\s]/, '_')
      end

      # RFC 2152 (UTF-7)
      def decode(s)
        s.gsub(/\+([A-Za-z0-9\/]*)-?/) { decode_chunk(Regexp.last_match[1]) }
      end

      def decode_sanitize(s)
        sanitize(decode(s))
      end

      private

      def decode_chunk(c)
        return '+' if c.size == 0
        c.unpack('m*')[0].bytes.each_slice(2).map { |a, b| ((a << 8) | b).chr }.join
      end
    end
  end
end
