require 'spec_helper'
require 'node'

describe Node do

  NODE_TEST_RANGE = (1..4)

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

  describe "#new" do
    it "takes one parameter and returns a Node instance" do
      @testNode.should be_an_instance_of Node
    end
  end

  describe "#name" do
    it "returns correct node name" do
      @testNode.name.should eql "test"
    end
  end

  it "has a method to add arcs" do
    @testNode.respond_to?(:addArc).should be_true
  end

  describe "#adjacentTo?" do
    NODE_TEST_RANGE.each do |i|
      it "correctly describes added nodes" do
        @growthNode.adjacentTo?( "#{i}" ).should be_true
      end
      it "correctly omits non-adjacent nodes" do
        @growthNode.adjacentTo?( "FOO" ).should            be_false
        @growthNode.adjacentTo?( "#{-i}" ).should          be_false
        @growthNode.adjacentTo?( @growthNode.name ).should be_false
      end
    end
  end

  describe "#distanceTo" do
    it "returns nil for non-adjacent nodes" do
      @addedNodes.each do |node|
        @testNode.distanceTo( node ).should be_nil
      end
    end
    it "returns the correct distance for adjacent nodes" do
      NODE_TEST_RANGE.each do |i|
        @growthNode.distanceTo( @addedNodes[i-1] ).should eql i
      end
    end
  end

  it "has a method named neighbors" do
    @testNode.respond_to?( :neighbours ).should   be_true
    @growthNode.respond_to?( :neighbours ).should be_true
  end

  describe "#neighbours" do
    it "returns an array" do
      @testNode.neighbours.should   be_an_instance_of Array
      @growthNode.neighbours.should be_an_instance_of Array
    end
    it "returns an array with the correct population counts" do
      @testNode.neighbours.count.should eql 0
      @growthNode.neighbours.count.should eql NODE_TEST_RANGE.count
    end
    it "correctly contains all adjacent nodes" do
      @addedNodes.each { |n|
        @growthNode.neighbours.include?(n).should be_true
      }
    end
    it "omits random nodes -- i.e. no false positive" do
      @testNode.neighbours.include?( Node.new("Foo") ).should   be_false
      @growthNode.neighbours.include?( Node.new("Bar") ).should be_false
      @addedNodes.each { |n|
        @testNode.neighbours.include?(n).should be_false
      }
    end
  end

end # public method check

describe_internally Node do

  before :each do
    @testNode = Node.new "test"
  end

  before :all do
    @growthNode = Node.new "growth"
    NODE_TEST_RANGE.each do |i|
      newNode = Node.new( "#{i}" )
      @growthNode.addArc( newNode, i )
    end
  end

  it "has an adjacency check" do
    @testNode.respond_to?(:adjacentTo?).should be_true
  end

  describe "#arcForNode" do
    NODE_TEST_RANGE.each do |i|
      it "retrieves the arc corresponding to the destination node" do
        # This is contrived...
        fetchNode = @growthNode.arcForName( "#{i}" ).destination
        @growthNode.arcForNode( fetchNode ).destination.should equal fetchNode
      end
      it "returns nil for non-adjacent nodes" do
        @growthNode.arcForNode( Node.new("FOO") ).should be_nil
        @growthNode.arcForName( @growthNode ).should     be_nil
      end
    end
  end

  describe "#arcForName" do
    NODE_TEST_RANGE.each do |i|
      it "retrieves the arc corresponding to destination name" do
        @growthNode.arcForName( "#{i}" ).destination.name.should eql "#{i}"
      end
      it "returns nil for non-adjacent destination names" do
        @growthNode.arcForName( "FOO" ).should            be_nil
        @growthNode.arcForName( "#{-i}" ).should          be_nil
        @growthNode.arcForName( @growthNode.name ).should be_nil
      end
    end
  end

end # private method check
