module Wopinator
  class LockId
    def initialize(id)
      self.id = id.to_s
    end

    def valid?
      valid_length? && valid_format? 
    end

    def present?
      !empty?
    end

    def empty?
      id.bytesize == 0
    end

    def eql?(other)
      to_s.eql?(other.to_s)
    end

    def ==(other)
      to_s == other.to_s
    end

    def !=(other)
      to_s != other.to_s
    end

    def to_s
      id
    end

    private

    MATCH_PRINTABLE = /^[[:print:]]+$/.freeze

    attr_accessor :id

    def valid_length?
      id.bytesize > 0 && id.bytesize <= 1024
    end

    def valid_format?
      !!(id =~ MATCH_PRINTABLE)
    end
  end
end
