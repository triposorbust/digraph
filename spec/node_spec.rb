require 'spec_helper'
require 'node'

describe Node do

  before :each do
    @testNode = Node.new "test"
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

  it "has an adjacency check" do
    @testNode.respond_to?(:adjacentTo?).should be_true
  end

  # expansion testing
  growthNode = Node.new "growth"
  (1..4).each do |i|
    newNode = Node.new( "#{i}" )
    growthNode.addArc( newNode, i )
    
    describe "#adjacentTo?" do
      it "correctly describes added nodes" do
        growthNode.adjacentTo?( "#{i}" ).should be_true
      end
      it "correctly omits non-adjacent nodes" do
        growthNode.adjacentTo?( "FOO" ).should           be_false
        growthNode.adjacentTo?( "#{-i}" ).should       be_false
        growthNode.adjacentTo?( growthNode.name ).should be_false
      end
    end
    
    describe "#arcForName" do
      it "retrieves the arc corresponding to destination name" do
        growthNode.arcForName( "#{i}" ).destination.should equal newNode
      end
      it "returns nil for non-adjacent destination names" do
        growthNode.arcForName( "FOO" ).should           be_nil
        growthNode.arcForName( "#{-i}" ).should       be_nil
        growthNode.arcForName( growthNode.name ).should be_nil
      end
    end
    
    describe "#arcForNode" do
      it "retrieves the arc corresponding to the destination node" do
        growthNode.arcForNode( newNode ).destination.should equal newNode
      end
      it "returns nil for non-adjacent nodes" do
        growthNode.arcForNode( Node.new("FOO") ).should be_nil
        growthNode.arcForName( growthNode ).should      be_nil
      end
    end

  end
  
end # class test
