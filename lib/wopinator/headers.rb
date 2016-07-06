module Wopinator
  class Headers
    include Enumerable
    MATCH = /^HTTP_X_WOPI_/.freeze

    def initialize(request)
      @_data = parse(request)
    end

    def get(name)
      @_data[name]
    end

    def each
      @_data.each do |k, v|
        yield k, v
      end
    end

    private

    def parse(request)
      {}.tap do |hash|
        request.env.each do |k, v|
          hash[k.gsub(MATCH, '').downcase.to_sym] = v if k =~ MATCH
        end
      end
    end
  end
end
