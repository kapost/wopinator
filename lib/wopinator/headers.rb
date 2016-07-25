module Wopinator
  class Headers
    include Enumerable

    PREFIX = 'X-WOPI-'.freeze
    LOCK = "#{PREFIX}Lock".freeze
    OLD_LOCK = "#{PREFIX}OldLock".freeze
    ITEM_VERSION = "#{PREFIX}ItemVersion".freeze
    PROOF = "#{PREFIX}Proof".freeze
    PROOF_OLD = "#{PREFIX}ProofOld".freeze
    TIMESTAMP = "#{PREFIX}Timestamp".freeze
    OVERRIDE = "#{PREFIX}Override".freeze
    SUGGESTED_TARGET = "#{PREFIX}SuggestedTarget".freeze
    RELATIVE_TARGET = "#{PREFIX}RelativeTarget".freeze

    def initialize(request = nil)
      if request
        self.data = parse(request)
      else
        self.data = {}
      end
    end

    def get(name)
      data[name.to_sym]
    end

    def set(name, value)
      data[name.to_sym] = value.to_s
    end

    def each
      data.each do |k, v|
        yield k, v
      end
    end

    private

    MATCH = /^(HTTP[-_])?X[-_]WOPI[-_]/i.freeze

    attr_accessor :data

    def parse(request)
      {}.tap do |hash|
        request.env.each do |k, v|
          hash[k.gsub(MATCH, '').downcase.to_sym] = v if k =~ MATCH
        end
      end
    end
  end
end
