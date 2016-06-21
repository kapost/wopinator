module Wopinator
  class Timestamp # 64 bit timestamp
    def initialize(timestamp)
      @_value = timestamp.to_i
    end

    def to_s
      @_value.to_s
    end

    def to_i
      @_value
    end

    def valid?
      !older_than_twenty_minutes?
    end

    def older_than_twenty_minutes?
      to_time < twenty_minutes_ago
    end

    def to_time
      # This is a 64 bit (long int) timestamp with a resolution
      # of 100 nano seconds. In order to convert this back into a
      # unix timestamp that we can work with, we substract
      # the "delta" and then multiply the resulting value by the 
      # inverse of 1e7 (10000000) which is 1e-7 (0.0000001)
      @_time ||= Time.at((@_value - 621355968000000000) * 1e-7)
    end

    private

    def twenty_minutes_ago
      Time.now - 1200
    end
  end
end
