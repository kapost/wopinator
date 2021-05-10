require 'time'
require 'wopinator/lock_id'

module Wopinator
  class Lock
    EXPIRES_IN = 1800.freeze # 30 minutes

    attr_reader :id, :old_id, :timestamp, :expires_in

    def initialize(id, old_id = nil, timestamp = Time.now, expires_in = EXPIRES_IN)
      self.id = id
      self.old_id = old_id
      self.timestamp = timestamp
      self.expires_in = expires_in
    end

    def eql?(lock)
      return false if invalid? || lock.invalid?

      if old_id.empty? && lock.old_id.valid?
        id == lock.old_id
      elsif old_id.valid? && lock.old_id.empty?
        old_id == lock.id
      else
        id == lock.id
      end
    end

    def !=(lock)
      !eql?(lock)
    end

    def ==(lock)
      eql?(lock)
    end

    def set(id)
      touch!
      self.id = id
    end

    def clear!
      self.timestamp = nil
      self.id = nil
      self.old_id = nil
    end

    def touch!
      self.timestamp = Time.now
    end

    def timestamp=(value)
      @timestamp = parse_timestamp(value)
    end

    def expired?
      (timestamp + expires_in) < Time.now
    end

    def empty?
      id.empty? && old_id.empty?
    end

    def invalid?
      !valid?
    end

    def valid?
      id.valid? && (old_id.valid? || old_id.empty?) && !expired?
    end

    def id=(value)
      @id = LockId.new(value)
    end

    def old_id=(value)
      @old_id = LockId.new(value)
    end

    private

    attr_writer :expires_in

    def parse_timestamp(timestamp)
      if timestamp.is_a?(Time)
        timestamp
      elsif timestamp.is_a?(String)
        Time.parse(timestamp)
      elsif timestamp.is_a?(Integer)
        Time.at(timestamp)
      else
        Time.now - expires_in
      end
    end
  end
end
