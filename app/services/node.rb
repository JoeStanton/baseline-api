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
