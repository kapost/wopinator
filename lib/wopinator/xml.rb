require 'ostruct'
require 'nokogiri'
require 'nori'

module Wopinator
  class Xml
    class << self
      def parse(xml)
        format(try_parse(xml))
      end

      private

      def try_parse(xml)
        if Nori.respond_to?(:new)
          Nori.new(parser: :nokogiri).parse(xml)
        else
          Nori.parse(xml, :nokogiri)
        end
      end

      def format(xml)
        OpenStruct.new.tap do |s|
          xml.each do |k, v|
            key = k.sub(/^@/, '')

            if v.is_a?(Hash)
              s[key] = format(v)
            elsif v.is_a?(Array)
              s["#{key}s"] = v.map { |vv| format(vv) }
            else
              s[key] = v
            end
          end
        end
      end
    end
  end
end
