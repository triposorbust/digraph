require 'spec_helper'
require 'graphFactory'

describe GraphFactory do

  before :each do
    @testGraph = GraphFactory.buildGraph( "AB1 BC2 CD3" )
  end

  describe "#buildGraph" do
    it "takes a string and returns a graph" do
      @testGraph.should be_an_instance_of Graph
    end
    it "adds the right number of nodes" do
      @testGraph.nodesCount.should eql 4
    end
    it "adds the correctly named nodes" do
      @testGraph.containsNodeWithName?("A").should be_true
      @testGraph.containsNodeWithName?("B").should be_true
      @testGraph.containsNodeWithName?("C").should be_true
    end
    it "does not add any random nodes" do
      @testGraph.containsNodeWithName?("E").should   be_false
      @testGraph.containsNodeWithName?("Foo").should be_false
    end
    it "adds corect edges" do
      a = @testGraph.nodeWithName("A")
      b = @testGraph.nodeWithName("B")
      c = @testGraph.nodeWithName("C")
      d = @testGraph.nodeWithName("D")
      a.adjacentTo?(b).should be_true
      b.adjacentTo?(c).should be_true
      c.adjacentTo?(d).should be_true
    end
    it "does not add any random edges" do
      a = @testGraph.nodeWithName("A")
      b = @testGraph.nodeWithName("B")
      c = @testGraph.nodeWithName("C")
      d = @testGraph.nodeWithName("D")
      a.adjacentTo?(c).should be_false
      b.adjacentTo?(d).should be_false
      b.adjacentTo?(a).should be_false
    end
  end
end

describe_internally GraphFactory do

  describe "#getWeight" do
    it "returns 0 if there are no digits at end" do
      GraphFactory.getWeight( "foo" ).should eql 0
      GraphFactory.getWeight( "" ).should    eql 0
      GraphFactory.getWeight( "75f" ).should eql 0
    end
    it "retrieves the last digit" do
      GraphFactory.getWeight( "foo7" ).should     eql 7.0
      GraphFactory.getWeight( "foo3foo7" ).should eql 7.0
    end
    it "retrives the ending digits" do
      GraphFactory.getWeight( "foo74" ).should      eql 74.0
      GraphFactory.getWeight( "foo43foo92" ).should eql 92.0
    end
    it "retrives the last digits and decimal point" do
      GraphFactory.getWeight( "foo7.55" ).should eql  7.55
      GraphFactory.getWeight( "fo.o0.15" ).should eql 0.15
    end
    it "only keeps the first decimal encountered" do
      GraphFactory.getWeight( "foo7.5.5" ).should eql       7.5
      GraphFactory.getWeight( "foo.192.168.0.1").should eql 0.192
    end
  end

  describe "#getNames" do
    it "returns an array" do
      GraphFactory.getNames( "AB" ).should be_an_instance_of Array
    end
    it "returns an empty list for empty string" do
      GraphFactory.getNames( "" ).should be_an_instance_of Array
      GraphFactory.getNames( "" ).should be_empty
    end
    it "splits at capital letters" do
      GraphFactory.getNames( "AB" ).should be_an_instance_of Array
      GraphFactory.getNames( "AB" ).count.should eql 2
    end
    it "correctly populates name list" do
      GraphFactory.getNames( "AB" )[0].should eql "A"
      GraphFactory.getNames( "AB" )[1].should eql "B"
    end
    it "allow multiple lower case letters" do
      GraphFactory.getNames( "AaaBbb" )[0].should eql "Aaa"
      GraphFactory.getNames( "AaaBbb" )[1].should eql "Bbb"
      GraphFactory.getNames( "FooBar" )[0].should eql "Foo"
      GraphFactory.getNames( "FooBar" )[1].should eql "Bar"
    end
    it "allows underscores" do
      GraphFactory.getNames( "F_ooB_ar" )[0].should eql "F_oo"
      GraphFactory.getNames( "F_ooB_ar" )[1].should eql "B_ar"
    end
    it "allows hyphens" do
      GraphFactory.getNames( "F-o-oB-a-r" )[0].should eql "F-o-o"
      GraphFactory.getNames( "F-o-oB-a-r" )[1].should eql "B-a-r"
    end
  end

  describe "#hashify" do
    it "returns a hash" do
      GraphFactory.hashify( "WaffleIron" ).should be_an_instance_of Hash
    end
    it "returns hash with source key" do
      GraphFactory.hashify( "WaffleIron" ).has_key?( :source ).should be_true
    end
    it "returns hash with destination key" do
      GraphFactory.hashify( "WaffleIron" ).has_key?( :destination ).should be_true
    end
    it "returns hash with weight key" do
      GraphFactory.hashify( "WaffleIron" ).has_key?( :weight ).should be_true
    end
    it "properly parses toy inputs" do
      h = GraphFactory.hashify( "WaffleIron8" )
      h[:source].should      eql "Waffle"
      h[:destination].should eql "Iron"
      h[:weight].should      eql 8.0
    end
    it "properly parses sample inputs" do
      h = GraphFactory.hashify( "AB10" )
      h[:source].should      eql "A"
      h[:destination].should eql "B"
      h[:weight].should      eql 10.0
    end    
  end

  describe "#nodeForName" do
    g    = Graph.new
    node = nil
    it "returns a node" do
      node = GraphFactory.nodeForName( g, "Foo" )
      node.should be_an_instance_of Node
    end
    it "returns a node with the correct name" do
      node.name.should eql "Foo"
    end
    it "adds it to the graph upon retrieval" do
      g.containsNodeWithName?( "Foo" ).should be_true
      g.containsNode?( node ).should          be_true
    end
    it "returns the same node on repeat" do
      GraphFactory.nodeForName( g, "Foo" ).should equal node
    end
  end

end
