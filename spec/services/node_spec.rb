require './app/services/graph.rb'
require './app/services/node.rb'

describe Node do
  before(:each) do
    Graph.reset!
    @graph = Graph.load
    @graph.stub(:save)
  end

  describe ".all" do
    it "should support querying all, constrained to the type" do
      class Dummy < Node; end
      node = Dummy.create
      Node.create
      Dummy.all.should == [node]
    end
  end

  describe ".find" do
    it "should support querying by ID" do
      Node.create

      node = Node.create
      Node.find(node.id).should == node
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

  describe "#save" do
    it "should not be persisted unless save is called" do
      node = Node.new
      node.should_not be_persisted
    end

    it "should persist a new node" do
      node = Node.new
      node.save
      node.should be_persisted
    end

    it "should update in place" do
      node = Node.new
      node.save
      node.save
      @graph.nodes.should have(1).item
    end
  end

  describe "#destroy!" do
    it "should remove the node and any associated edges" do
      n1 = Node.create
      n2 = Node.create
      n1.relate(n2, :dependant)

      n1.destroy!

      @graph.nodes.should == [n2]
      @graph.edges.should be_empty
    end
  end


  describe "Relationships" do
    before(:each) do
      @graph = Graph.load

      @n1 = Node.create
      @n2 = Node.create

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

    describe "#outgoing" do
      it "should list related nodes via outgoing relationships" do
        @n1.outgoing.should == [@n2]
      end

      it "should constrain by type" do
        @n1.outgoing(:depends_on).should == [@n2]
        @n1.outgoing(:nothing).should be_empty
      end
    end

    describe "#incoming" do
      it "should list related nodes via incoming relationships" do
        @n2.incoming.should == [@n1]
      end

      it "should constrain by type" do
        @n2.incoming(:depends_on).should == [@n1]
        @n2.incoming(:nothing).should be_empty
      end
    end
  end

end
