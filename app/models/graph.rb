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

class Node
  attr_accessor :id, :graph

  def initialize(graph)
    @id = graph.nodes.size + 1
    @graph = graph
  end

  def relate(to, type)
    return if out(type).include? to
    graph.edges << Edge.new(self, to, type)
  end

  def in(type = nil)
    edges = graph.edges.select { |edge| edge.to }
    edges = edges.select { |edge| edge.type == type } if type
    edges.map(&:from)
  end

  def out(type = nil)
    edges = graph.edges.select { |edge| edge.from }
    edges = edges.select { |edge| edge.type == type } if type
    edges.map(&:to)
  end
end

class Edge
  attr_reader :from, :to, :type

  def initialize(from, to, type)
    @from = from
    @to = to
    @type = type
  end
end
