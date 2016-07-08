require 'wopinator/timestamp'
require 'wopinator/signature'
require 'wopinator/discovery'
require 'wopinator/headers'
require 'wopinator/lock'

module Wopinator
  class Request
    def initialize(request, options = {})
      self.raw_request = request
      self.options = options
    end

    def valid?
      signature.verify(proof, old_proof, proof_key, old_proof_key)
    end

    def action
      @_action ||= determine_action
    end

    def method
      @_method ||= env['REQUEST_METHOD'].downcase.to_sym
    end

    def lock
      @_lock ||= Lock.new(headers.get(:lock), headers.get(:oldlock))
    end

    def url
      @_url ||= raw_request.url
    end

    def headers
      @_headers ||= Headers.new(raw_request)
    end

    private

    attr_accessor :raw_request, :options

    CONTENTS_PATH = /\/contents$/.freeze

    def determine_action
      override = headers.get(:override)
      return determine_action_from_override(override) if override

      if path =~ CONTENTS_PATH
        method == :post ? :put_file : :get_file
      else
        :get_file_info
      end
    end

    def determine_action_from_override(override)
      override_action = override.downcase.to_sym
      case override_action
      when :put_relative
        :put_relative_file
      when :put
        :put_file
      when :lock
        if lock.old_id.empty?
          :lock
        else
          :unlock_and_relock
        end
      else
        override_action
      end
    end

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

    def value_for_param(name)
      raw_request.params[name.to_s]
    end

    def path
      @_path ||= env['REQUEST_PATH']
    end

    def env
      @_env ||= raw_request.env
    end
  end
end
