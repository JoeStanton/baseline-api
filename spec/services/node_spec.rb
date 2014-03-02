require './app/services/graph.rb'
require './app/services/node.rb'

describe Node do
  before do
    @graph = Graph.load
  end

  describe ".all" do
    it "should support querying all, constrained to the type" do
      class Dummy < Node; end
      node = Dummy.new
      @graph.nodes << node
      @graph.nodes << Node.new
      Dummy.all.should == [node]
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

describe Node do
  before(:all) do
    @graph = Graph.load
    @n1 = Node.new
    @n2 = Node.new

    @graph.nodes << @n1
    @graph.nodes << @n2
    @n1.relate(@n2, :depends_on)
  end

  describe "#relate" do
    it "should create the relationship" do

      edge = @graph.edges.first
      @graph.edges.should have(1).item
      edge.from.should == @n1
      edge.to.should == @n2
      edge.type.should == :depends_on
    end

    it "should not create duplicate relationships" do
      @n1.relate(@n2, :depends_on)
      @graph.edges.should have(1).item
    end
  end

  describe "#out" do
    it "should list related nodes via outgoing relationships" do
      @n1.out.should == [@n2]
    end

    it "should constrain by type" do
      @n1.out(:depends_on).should == [@n2]
      @n1.out(:nothing).should be_empty
    end
  end

  describe "#in" do
    it "should list related nodes via incoming relationships" do
      @n2.in.should == [@n1]
    end

    it "should constrain by type" do
      @n2.in(:depends_on).should == [@n1]
      @n2.in(:nothing).should be_empty
    end
  end

  after(:all) do
    Graph.reset!
  end
end
