require 'spec_helper'
require 'graph'

describe Graph do

  TEST_RANGE = (1..4)

  before :each do
    @testGraph = Graph.new
  end

  before :all do
    @growthGraph = Graph.new
    TEST_RANGE.each do |i|
      newNode = Node.new( "#{i}" )
      @growthGraph.addNode( newNode )
    end
  end

  describe "#nodes" do
    it "returns an array of nodes" do
      @testGraph.nodes.should   be_an_instance_of Array
      @growthGraph.nodes.should be_an_instance_of Array
      @testGraph.nodes.each   { |n| n.should be_an_instance_of Node }
      @growthGraph.nodes.each { |n| n.should be_an_instance_of Node }
    end
  end

  describe "#nodeNames" do
    it "returns an array of strings" do
      @testGraph.nodeNames.should   be_an_instance_of Array
      @growthGraph.nodeNames.should be_an_instance_of Array
      @testGraph.nodeNames.each   { |n| n.should be_an_instance_of String }
      @growthGraph.nodeNames.each { |n| n.should be_an_instance_of String }
    end
  end

  it "has a method for adding nodes" do
    @testGraph.respond_to?( :addNode ).should be_true
  end

  it "has a method for adding arcs" do
    @testGraph.respond_to?( :addArc ).should be_true
  end

  describe "#new" do
    it "creates a new Graph instance" do
      @testGraph.should be_an_instance_of Graph
    end
    it "creates an empty Graph" do
      @testGraph.should have(0).nodes
    end
  end

  describe "#addNode" do
    it "correctly adds elements to graph" do
      @growthGraph.nodes.count.should eql TEST_RANGE.count
      TEST_RANGE.each do |i|
        @growthGraph.nodeNames.include?( "#{i}" ).should be_true
      end
    end
    it "correctly omits elements from graph addition" do
      TEST_RANGE.each do |i|
        @growthGraph.nodeNames.include?( "#{-i}" ).should be_false
      end
    end
  end


end
