require './app/services/graph.rb'
require './app/services/node.rb'

describe Node do
  before do
    @graph = Graph.load
  end

  describe ".all" do
    it "should support querying all" do
      node = Node.new
      @graph.nodes << node
      Node.all.should == [node]
    end
  end

  describe "#new" do
    it "should support hash initialization" do
      class Dummy < Node
        attr_accessor :name
      end

      node = Dummy.new(name: "Joe")
      node.name.should == "Joe"
    end
  end
end
