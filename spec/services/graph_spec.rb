describe Graph do
  describe ".new" do
    g = Graph.new

    it "should be empty" do
      g.nodes.should be_empty
      g.edges.should be_empty
    end
  end

  describe ".path" do
    it "should be constructed based on the environment" do
      Graph.path.should == "db/test.db"
    end
  end

  describe "load / save", slow: true do
    describe ".load" do
      it "should return a new database if one doesn't exist" do
        Graph.should_receive(:new)
        Graph.load
      end

      it "should be a singleton" do
        Graph.load.should == Graph.load
      end
    end

    it "should round-trip a database successfully" do
      sample = Graph.load
      class Sample < Node
        attr_accessor :i
      end
      sample.nodes = [1, 2, 3].map { |i| Sample.new(i: i) }
      sample.edges = edges = [ Edge.new(1, 2, :friend) ]

      sample.save
      Graph.reset!

      loaded = Graph.load
      loaded.nodes.map(&:i).should == [1, 2, 3]
      loaded.edges.should == edges

    end
  end

  after(:each) do
    File.unlink "db/test.db" if File.exists? "db/test.db"
    Graph.reset!
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
