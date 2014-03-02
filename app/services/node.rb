class Node
  attr_accessor :id
  include ActiveModel::Model

  def initialize(hash = nil)
    super
  end

  def self.create(hash = nil)
    node = self.new(hash)
    node.save
  end

  def graph
    Graph.load
  end

  def save
    graph.nodes << self
    @id = graph.nodes.size + 1
    graph.save
    self
  end

  def destroy!
    graph.nodes.delete self
    outgoing.each(&:destroy)
    incoming.each(&:destroy)
  end

  def persisted?
    id.present?
  end

  def relate(to, type)
    raise RuntimeError, 'Node must be saved before it can be related.' unless persisted?
    return if outgoing(type).include? to
    edge = Edge.new(self, to, type)
    graph.edges << edge
  end

  def incoming(type = nil)
    edges = graph.edges.select { |edge| edge.to }
    edges = edges.select { |edge| edge.type == type } if type
    edges.map(&:from)
  end

  def outgoing(type = nil)
    edges = graph.edges.select { |edge| edge.from }
    edges = edges.select { |edge| edge.type == type } if type
    edges.map(&:to)
  end

  def self.all
    Graph.load.nodes.select { |n| n.is_a?(self) }
  end

  def self.find(id)
    raise ArgumentError, 'An ID must be specified' if id.blank?
    id = id.to_i
    all.find { |n| n.id == id }
  end
end
