class Node
  attr_accessor :id
  include ActiveModel::Model

  def initialize(hash = nil)
    super
  end

  def self.create(*args)
    node = self.new(*args)
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
    outgoing_edges.each(&:destroy!)
    incoming_edges.each(&:destroy!)
    true
  end

  def persisted?
    id.present?
  end

  def relate(to, type)
    raise RuntimeError, 'Node must be saved before it can be related.' unless persisted?
    return if outgoing(type).include? to
    Edge.create(self, to, type)
  end

  def incoming_edges(type = nil)
    edges = graph.edges.select { |edge| edge.to }
    edges = edges.select { |edge| edge.type == type } if type
    edges
  end

  def incoming(type = nil)
    incoming_edges(type).map(&:from)
  end

  def outgoing_edges(type = nil)
    edges = graph.edges.select { |edge| edge.from }
    edges = edges.select { |edge| edge.type == type } if type
    edges
  end

  def outgoing(type = nil)
    outgoing_edges(type).map(&:to)
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
