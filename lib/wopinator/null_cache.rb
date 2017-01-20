module Wopinator
  class NullCache
    def fetch(_key, _options = {})
      yield
    end

    def delete(_key)
      true
    end
  end
end
