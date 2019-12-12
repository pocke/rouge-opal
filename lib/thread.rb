# polyfill

class Thread
  def self.current
    @current ||= self.new
  end

  def initialize
    @values = {}
  end

  def [](k)
    @values[k]
  end

  def []=(k, v)
    @values[k] = v
  end
end
