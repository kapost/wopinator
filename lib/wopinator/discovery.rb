require 'ostruct'
require 'wopinator/proof_key'
require 'wopinator/http_client'

module Wopinator
  class Discovery
    attr_reader :url

    def initialize(url)
      self.url = url
    end

    def new_proof_key
      @_new_proof_key ||= ProofKey.new(proof_key.value, proof_key.modulus, proof_key.exponent)
    end

    def old_proof_key
      @_old_proof_key ||= ProofKey.new(proof_key.oldvalue, proof_key.oldmodulus, proof_key.oldexponent)
    end

    def apps
      @_apps ||= xml.xpath('//wopi-discovery/net-zone/app').map do |app|
        OpenStruct.new(Hash.from_xml(app.to_s).values.first).tap do |s|
          s.actions = s.delete_field(:action).map { |a| OpenStruct.new(a) }
        end
      end
    end

    private

    attr_writer :url

    def proof_key
      @_proof_key ||= OpenStruct.new(Hash.from_xml(xml.xpath('//wopi-discovery/proof-key').to_s).values.first)
    end

    def xml
      @_xml ||= Nokogiri::XML(HTTPClient.get(url).body)
    end
  end
end
