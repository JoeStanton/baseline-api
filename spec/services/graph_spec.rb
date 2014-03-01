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
    it "should return a new database if one doesn't exist" do
      Graph.reset!
      Graph.should_receive(:new)
      Graph.load
    end

    it "should be a singleton" do
      Graph.load.should == Graph.load
    end

    describe "save/restore" do
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

      after do
        File.unlink "db/test.db" if File.exists? "db/test.db"
      end

    end
  end

  after(:each) do
    Graph.reset!
  end
end
