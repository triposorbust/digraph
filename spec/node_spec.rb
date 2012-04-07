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

  describe "#arcs" do
    it "returns an array of arcs" do
      @testNode.arcs.should be_an_instance_of Array
    end
    it "is initially empty" do
      @testNode.arcs.should be_empty
    end
  end

  # expansion testing
  growthNode = Node.new "growth"
  (0..2).each do |i|
    newNode = Node.new( "#{i}" )

    describe "#arcs" do
      it "after #{i} added arcs, had up-to-date arcs" do
        growthNode.addArc( newNode, i )
        growthNode.should have(i+1).arcs
        growthNode.arcs[i].should be_an_instance_of Arc
      end
    end

    describe "#adjacentTo?" do
      it "correctly describes added nodes" do
        growthNode.adjacentTo?( "#{i}" ).should be_true
      end
      it "correctly describes non-adjacent nodes" do
        growthNode.adjacentTo?( "FOO" ).should           be_false
        growthNode.adjacentTo?( "#{i+1}" ).should        be_false
        growthNode.adjacentTo?( growthNode.name ).should be_false
      end
    end
    
    describe "#arcForName" do
      it "retrieves the arc corresponding to destination name" do
        growthNode.arcForName( "#{i}" ).destination.should equal newNode
      end
      it "returns nil for non-adjacent nodes" do
        growthNode.arcForName( "FOO" ).should           be_nil
        growthNode.arcForName( growthNode.name ).should be_nil
      end
    end
      
    describe "#arcForNode" do
      it "retrieves the arc corresponding to the destination node" do
        growthNode.arcForName( "#{i}" ).destination.should equal newNode
      end
      it "returns nil for non-adjacent nodes" do
        growthNode.arcForName( "FOO" ).should           be_nil
        growthNode.arcForName( growthNode.name ).should be_nil
      end
    end
  end # expansion testing

end
