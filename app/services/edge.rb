class Edge < Value.new(:from, :to, :type)
  def graph
    Graph.load
  end

  def self.create(*args)
    edge = self.new(*args)
    edge.save
  end

  def save
    graph.edges << self
    graph.save
    self
  end

  def destroy!
    graph.edges.delete(self)
  end
end
