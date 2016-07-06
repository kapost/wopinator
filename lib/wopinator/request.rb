require 'wopinator/timestamp'
require 'wopinator/signature'
require 'wopinator/discovery'
require 'wopinator/headers'

module Wopinator
  class Request
    def initialize(request, options = {})
      self.raw_request = request
      self.options = options
    end

    def valid?
      signature.verify(proof, old_proof, proof_key, old_proof_key)
    end

    private

    attr_accessor :raw_request, :options

    def proof_key
      @_proof_key ||= discovery.proof_key
    end

    def old_proof_key
      @_old_proof_key ||= discovery.old_proof_key
    end

    def discovery
      @_discovery ||= Discovery.new(options)
    end

    def signature
      @_signature ||= Signature.new(access_token, timestamp, url)
    end

    def url
      @_url ||= raw_request.url
    end

    def access_token
      @_access_token ||= value_for_param(:access_token)
    end

    def timestamp
      @_timestamp ||= Timestamp.new(headers.get(:timestamp))
    end

    def proof
      @_proof ||= headers.get(:proof)
    end

    def old_proof
      @_old_proof ||= headers.get(:proofold)
    end

    def headers
      @_headers ||= Headers.new(raw_request)
    end

    def value_for_param(name)
      raw_request.params[name.to_s]
    end
  end
end
