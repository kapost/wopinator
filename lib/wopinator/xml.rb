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

      def parser_class
        Nori
      end

      def try_parse(xml)
        if parser_class.respond_to?(:parse)
          parser_class.parse(xml, :nokogiri)
        else
          parser_class.new(parser: :nokogiri).parse(xml)
        end
      end

      def format(xml)
        OpenStruct.new.tap do |s|
          xml.each do |k, v|
            key = k.to_s.sub(/^@/, '')

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
