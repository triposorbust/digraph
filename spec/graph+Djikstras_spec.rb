require 'spec_helper'
require 'graphFactory'
require 'graph+Djikstras'

describe Node do

  D_NODE_TEST_RANGE = (1..4)

  before :each do
    @testNode = Node.new "test"
  end

  before :all do
    @growthNode = Node.new "growth"
    @addedNodes = Array.new
    NODE_TEST_RANGE.each do |i|
      newNode = Node.new( "#{i}" )
      @addedNodes << newNode
      @growthNode.addArc( newNode, i )
    end
  end

  it "has a method called adjacency_hash" do
    @testNode.respond_to?( :adjacency_hash ).should   be_true
    @growthNode.respond_to?( :adjacency_hash ).should be_true
  end

  describe "#adjacency_hash" do
    it "returns a hash" do
      @testNode.adjacency_hash.should be_an_instance_of   Hash
      @growthNode.adjacency_hash.should be_an_instance_of Hash
    end
    it "should contain the same number of elements as arcs" do
      @testNode.adjacency_hash.count.should   eql 0
      @growthNode.adjacency_hash.count.should eql D_NODE_TEST_RANGE.count
    end
    it "should return nil for non-elements" do
      @addedNodes.each { |node|
        @testNode.adjacency_hash[ node.name ].should be_nil
      }
    end
    it "should store accurate weights for elements" do
      D_NODE_TEST_RANGE.each { |i|
        node = @addedNodes[ i-1 ]
        @growthNode.adjacency_hash[ node.name ].should eql i
      }
    end
  end

end

describe Graph do

  before :each do
    @testGraph = Graph.new
    graphStr   = "AB5, BC4, CD8, DE6, AD5, CE2, EB3, AE7"
    @fullGraph = GraphFactory.buildGraph( graphStr )
  end

  it "has a method called shortest paths" do
    @testGraph.respond_to?( :shortest_paths ).should be_true
    @fullGraph.respond_to?( :shortest_paths ).should be_true
  end

  describe "#shortest_paths" do
    it "returns a hash" do
      @fullGraph.shortest_paths( "A" ).should be_an_instance_of Hash
      @fullGraph.shortest_paths( "D" ).should be_an_instance_of Hash
    end
    it "returns a hash with k-v pairs for all nodes" do
      @fullGraph.shortest_paths( "A" ).count.should   eql 5
      @testGraph.shortest_paths( "Foo" ).count.should eql 0
    end
    it "returns nil-valued hashes for node name not in graph" do
      @fullGraph.shortest_paths( "G" ).values.each do |distance|
        distance.should be_nil
      end
    end
    it "returns accurate shortest-distance values for valid start nodes" do
      distances = @fullGraph.shortest_paths( "A" )
      distances["B"].should eql 5.0
      distances["C"].should eql 9.0
      distances["D"].should eql 5.0
      distances["E"].should eql 7.0
    end
    it "returns accurate shortest-distance values for valid start nodes" do
      distances = @fullGraph.shortest_paths( "B" )
      distances["A"].should be_nil
      distances["B"].should eql 0
      distances["C"].should eql 4.0
      distances["D"].should eql 12.0
      distances["E"].should eql 6.0
    end
  end

end

describe_internally Graph do

  before :each do
    @testGraph = Graph.new
    graphStr   = "AB5, BC4, CD8, DE6, AD5, CE2, EB3, AE7"
    @fullGraph = GraphFactory.buildGraph( graphStr )
  end

  it "has a method named djikstras" do
    @testGraph.respond_to?( :djikstras! ).should be_true
    @fullGraph.respond_to?( :djikstras! ).should be_true
  end

  it "has a method named priorityNode" do
    @testGraph.respond_to?( :priorityNode ).should be_true
    @fullGraph.respond_to?( :priorityNode ).should be_true
  end

  it "has a method named ncompare for nullables" do
    @testGraph.respond_to?( :ncompare ).should be_true
    @fullGraph.respond_to?( :ncompare ).should be_true
  end

  describe "#priorityNode" do
    it "returns nil for empty hash / node array" do
      @testGraph.priorityNode( Hash.new, Array.new ).should be_nil
    end
    it "returns nil when there are no assigned priorities" do
      h = Hash.new
      h["A"] = h["B"] = h["C"] = nil
      a = [ Node.new( "A" ), Node.new( "B" ), Node.new( "C" ) ]

      @testGraph.priorityNode( h, a ).should be_nil
    end
    it "returns correct Node when only one initial priority is assigned" do
      h = Hash.new
      h["A"] = h["B"] = nil;
      h["C"] = 0
      a = [ Node.new( "A" ), Node.new( "B" ), Node.new( "C" ) ]

      @testGraph.priorityNode( h, a ).should be_an_instance_of Node
      @testGraph.priorityNode( h, a ).name.should eql "C"
    end
    it "returns the correct Node when multiple priorities assigned" do
      h = Hash.new
      h["A"] = 15
      h["B"] = 30
      h["C"] = 0
      a = [ Node.new( "A" ), Node.new( "B" ), Node.new( "C" ) ]

      @testGraph.priorityNode( h, a ).should be_an_instance_of Node
      @testGraph.priorityNode( h, a ).name.should eql "C"      
    end
  end

  describe "#ncompare" do
    it "correctly compares non nil values" do
      @testGraph.ncompare( 0, 1 ).should eql -1
      @testGraph.ncompare( 1, 0 ).should eql  1
      @testGraph.ncompare( 0, 0 ).should eql  0
    end
    it "returns -1 if the second argument is nil" do
      @testGraph.ncompare( 1, nil ).should eql -1
    end
    it "returns 1 if the first argument is nil" do
      @testGraph.ncompare( nil, 1 ).should eql 1
    end
    it "returns 0 for nil compare to nil" do
      @testGraph.ncompare( nil, nil ).should eql 0
    end
  end

end
