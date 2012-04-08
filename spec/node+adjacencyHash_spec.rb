require 'spec_helper'
require 'node+adjacencyHash'

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
