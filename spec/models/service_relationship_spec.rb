require 'spec_helper'

describe Service do
  before do
    @nodeA = Service.create(name: 'Service A')
    @nodeB = Service.create(name: 'Service B')

    @rel = Dependency.build(@nodeA, @nodeB)
    @rel2 = Relationship.build(@nodeA, @nodeB)
  end

  describe "building edges" do
    it "should construct the correct relationship" do
      @rel.source_type.should == "Service"
      @rel.source_id.should == @nodeA.id
      @rel.source.should == @nodeA

      @rel.target_type.should == "Service"
      @rel.target_id.should == @nodeB.id
      @rel.target.should == @nodeB

      @rel.type.should == "Dependency"
    end
  end

  describe "incoming edges" do
    it "should return all edges" do
      @nodeA.incoming_edges.should have(0).items
      @nodeB.incoming_edges.should have(2).items
    end

    it "should constrain edges by type" do
      @nodeB.incoming_edges(Dependency).should == [@rel]
    end
  end

  describe "outgoing edges" do
    it "should return all edges" do
      @nodeB.outgoing_edges.should have(0).items
      @nodeA.outgoing_edges.should have(2).items
    end

    it "should constrain edges by type" do
      @nodeA.outgoing_edges(Dependency).should == [@rel]
    end
  end

  describe "incoming nodes" do
    it "should traverse edges" do
      @nodeA.outgoing(Dependency).should == [@nodeB]
      @nodeB.incoming(Dependency).should == [@nodeA]
    end
  end
end
