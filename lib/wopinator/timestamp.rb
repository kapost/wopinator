module Wopinator
  class Timestamp # 64 bit timestamp
    def initialize(timestamp)
      @_value = timestamp.to_i
    end

    def to_i
      @_value
    end

    def to_time
      # MSZ: document this *magic*
      @_time ||= Time.at((@_value - 621355968000000000) * 1e-7)
    end
  end
end
