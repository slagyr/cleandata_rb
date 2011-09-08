module Cleandata

  class DotHash < Hash

    def method_missing(name, *args, &block)
      if has_key?(name)
        fetch(name)
      else
        super.method_missing(name, *args, &block)
      end
    end

  end

end