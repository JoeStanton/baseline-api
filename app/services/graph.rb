class Graph
  attr_accessor :nodes, :edges

  def self.path
    "db/#{Rails.env}.db"
  end

  def self.load
    return @instance if @instance

    if File.exists?(path)
      @instance = Marshal.load(File.read(path))
    else
      @instance = Graph.new
    end
  end

  def self.reset!
    @instance = nil
  end

  def save
    File.open(self.class.path, 'w') {|f| f.write(Marshal.dump(self)) }
  end

  private

  def initialize
    @nodes = []
    @edges = []
  end
end
