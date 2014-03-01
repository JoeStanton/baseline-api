class Graph
  attr_accessor :nodes, :edges

  def initialize(name)
    @name = name
    @nodes = []
    @edges = []
  end

  def self.path(name)
    "db/#{name}.db"
  end

  def self.load(name)
    db = path(name)
    if File.exists?(db)
      Marshal.load(File.read(db))
    else
      Graph.new(name)
    end
  end

  def save
    File.open(self.class.path(@name), 'w') {|f| f.write(Marshal.dump(self)) }
  end
end
