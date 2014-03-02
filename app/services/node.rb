class Node
  attr_accessor :id
  include ActiveModel::Model

  def initialize(hash = nil)
    @id = graph.nodes.size + 1
    super
  end

  def graph
    Graph.load
  end

  def relate(to, type)
    return if out(type).include? to
    edge = Edge.new(self, to, type)
    graph.edges << edge
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

  def self.all
    Graph.load.nodes.select { |n| n.is_a?(self) }
  end
end
