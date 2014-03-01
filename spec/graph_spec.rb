require './app/models/graph.rb'

describe Graph do
  describe ".new" do
    g = Graph.new "new_test"

    it "should be empty" do
      g.nodes.should be_empty
      g.edges.should be_empty
    end
  end

  describe ".path" do
    it "should be constructed based on the environment" do
      Graph.path("test").should == "db/test.db"
    end
  end

  describe "load / save", slow: true do
    describe ".load" do
      it "should return a new database if one doesn't exist" do
        Graph.should_receive(:new).with("fake")
        Graph.load("fake")
      end
    end

    it "should round-trip a database successfully" do
      sample = Graph.load "round-trip"
      sample.nodes = nodes = [1, 2, 3]
      sample.edges = edges = [ {from: 1, to: 2} ]
      sample.save

      loaded = Graph.load "round-trip"
      loaded.nodes.should == nodes
      loaded.edges.should == edges

      File.unlink "db/round-trip.db"
    end
  end
end
