require 'wopinator/null_cache'
require 'wopinator/xml'
require 'wopinator/proof_key'
require 'wopinator/http_client'

module Wopinator
  class Discovery
    EMPTY = {}.freeze
    CACHE_KEY = "wopinator_discovery_xml".freeze
    EXPIRES_IN = 43200.freeze # 12 hours
    URLS =
    {
      production: 'https://onenote.officeapps.live.com/hosting/discovery',
      test:       'https://onenote.officeapps-df.live.com/hosting/discovery'
    }.freeze

    attr_reader :url, :cache, :expires_in

    def initialize(options = {})
      self.url        = URLS.fetch(options.fetch(:env, :production))
      self.cache      = options.fetch(:cache, NullCache.new)
      self.expires_in = options.fetch(:expires_in, EXPIRES_IN)
    end

    def proof_key
      @_proof_key ||= ProofKey.new(proof_keys.value, proof_keys.modulus, proof_keys.exponent)
    end

    def old_proof_key
      @_old_proof_key ||= ProofKey.new(proof_keys.oldvalue, proof_keys.oldmodulus, proof_keys.oldexponent)
    end

    def apps
      @_apps ||= locate(:wopi_discovery, :net_zone, :apps)
    end

    def reload!
      @_raw_xml       = nil
      @_xml           = nil
      @_proof_keys    = nil
      @_apps          = nil
      @_proof_key     = nil
      @_old_proof_key = nil

      cache.delete(CACHE_KEY)
    end

    private

    attr_writer :url, :cache, :expires_in

    def proof_keys
      @_proof_keys ||= locate(:wopi_discovery, :proof_key)
    end

    def locate(*args)
      val = xml

      args.each do |arg|
        val = val[arg] || EMPTY
      end

      val
    end

    def xml
      @_xml ||= Xml.parse(raw_xml)
    end

    def raw_xml
      @_raw_xml ||= cache.fetch(CACHE_KEY, expires_in: expires_in) do
        HTTPClient.get(url).body
      end
    end
  end
end
