require 'ostruct'

module Wopinator
  class FileInfo
    class EmptyPropertyError < StandardError; end

    module Extension
      def to_json
        validate!
        to_h.to_json
      end

      def validate!
        to_h.each do |k, v|
          raise EmptyPropertyError, k if empty_property?(v)
        end
      end

      private

      def empty_property?(v)
        v.nil? || (v.respond_to?(:size) && v.size == 0)
      end
    end

    class << self
      def new
        OpenStruct.new.tap do |instance|
          instance.extend(Extension)
        end
      end
    end
  end
end
