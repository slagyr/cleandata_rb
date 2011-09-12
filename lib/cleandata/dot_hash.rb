module Cleandata

  module Dottable

    def method_missing(name, *args, &block)
      if has_key?(name)
        fetch(name)
      else
        super.method_missing(name, *args, &block)
      end
    end

  end

  class DotHash < Hash

    include Dottable

  end

end

class Hash

  def dottable
    self.extend Cleandata::Dottable
  end

end