module Wopinator
  class NullCache
    def fetch(key, options = {})
      yield
    end

    def delete(key)
      true
    end
  end
end
