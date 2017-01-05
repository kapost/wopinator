require 'addressable/uri'
require 'ostruct'
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

    attr_reader :url, :env, :cache, :expires_in

    def initialize(options = {})
      self.env        = options.fetch(:env, default_env)
      self.url        = URLS.fetch(env)
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
      @_apps ||= locate(:wopi_discovery, :net_zone, :apps).map { |app| format_app(app) }
    end

    def resolve(name, ext, src = nil, params = {})
      resolve_cache["#{name}_#{ext}_#{src.nil?}"] ||= OpenStruct.new.tap do |s|
        app, action = find_app_and_action(name, ext)
        if app && action
          s.favicon_url = format_favicon_url(app)
          s.action_url = format_action_url(action, src, params)
        end
      end
    end

    def reload!
      @_resolve_cache = nil
      @_raw_xml       = nil
      @_xml           = nil
      @_proof_keys    = nil
      @_apps          = nil
      @_proof_key     = nil
      @_old_proof_key = nil

      cache.delete(CACHE_KEY)
    end

    private

    attr_writer :url, :env, :cache, :expires_in

    def resolve_cache
      @_resolve_cache ||= {}
    end

    def find_app_and_action(name, ext)
      action = nil
      app = nil

      if name && ext
        app = apps.detect do |a|
          action = find_action(a, name, ext)
        end
      end

      [app, action]
    end

    def find_action(app, name, ext)
      app.actions.detect { |action| action.name == name && action.ext == ext }
    end

    def format_favicon_url(app)
      app.favIconUrl || app.fav_icon_url
    end

    def format_action_url(action, src = nil, params = {})
      filtered_params = filter_action_query_params(action.urlsrc, params)

      uri = parse_url(action.urlsrc)
      uri.query_values = format_action_query(uri.query_values, src, filtered_params)
      uri.to_s
    end

    def format_action_query(query, src = nil, params = {})
      query ||= {}
      query.merge!(params)
      query['WOPISrc'] = src if src
      query.any? ? query : nil
    end

    def parse_url(url)
      Addressable::URI.parse(url.gsub(/&#38;/, '&').gsub(/<.*?=.*?>/, '').gsub(/(\?|&)$/, ''))
    end

    def filter_action_query_params(url, params)
      return {} unless params.any?

      supported = extract_supported_action_query_params(url)

      {}.tap do |hash|
        params.each do |k, v|
          if key = supported[k]
            hash[key] = v
          end
        end
      end
    end

    def format_app(app)
      app.actions = Array(app.action) if app.actions.nil?
      app
    end

    #
    # Extracts placeholder action query params into a Hash.
    #
    # Input
    #
    #   https://excel.officeapps-df.live.com/x/_layouts/xlviewerinternal.aspx?&lt;ui=UI_LLCC&amp;&gt;&lt;rs=DC_LLCC&amp;&gt;&lt;dchat=DISABLE_CHAT&amp;&gt;&lt;IsLicensedUser=BUSINESS_USER&amp;&gt;
    #
    # Output
    #
    #   {
    #     'UI_LLCC' => 'ui',
    #     'DC_LLCC' => 'rs',
    #     'DISABLE_CHAT' => 'dchat',
    #     'BUSINESS_USER' => 'IsLicensedUser'
    #   }
    #
    def extract_supported_action_query_params(url)
      Hash[url.gsub(/&#38;/, '&').scan(/<(.*?=.*?)>/).map { |m| m.first.chomp('&').split('=').reverse }]
    end

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
      @_xml ||= Xml.parse(raw_xml.to_s)
    end

    def raw_xml
      @_raw_xml ||= cache.fetch(CACHE_KEY, expires_in: expires_in) { fetch_raw_xml }
    end

    def fetch_raw_xml
      response = HTTPClient.get(url)
      response.code == 200 ? response.body : nil
    end

    def default_env
      @_defaul_env ||= (ENV['WOPI_ENV'] == 'test' ? :test : :production)
    end
  end
end
