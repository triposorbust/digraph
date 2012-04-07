require 'spec_helper'
require 'node'

describe Node do

  before :each do
    @testNode = Node.new "Test"
  end

  describe "#new" do
    it "takes one parameter and returns a Node instance" do
      @testNode.should be_an_instance_of Node
    end
  end

  describe "#name" do
    it "returns correct node name" do
      @testNode.name.should eql "Test"
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

    growthNode = Node.new "growing"
    (0..4).each do |i|
      it "after #{i} added arcs, had up-to-date arcs" do
        growthNode.addArc( Node.new("#{i}"), 0 )
        growthNode.should have(i+1).arcs
        growthNode.arcs[i].should be_an_instance_of Arc
        growthNode.adjacentTo?( "#{i}" ).should be_true
      end
    end
  end


      

end
