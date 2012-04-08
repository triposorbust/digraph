require 'spec_helper'
require 'graph'

describe Graph do

  GRAPH_TEST_RANGE = (1..4)

  before :each do
    @testGraph = Graph.new
  end

  before :all do
    @nodes = Array.new
    @growthGraph = Graph.new
    GRAPH_TEST_RANGE.each do |i|
      newNode = Node.new( "#{i}" )
      @growthGraph.addNode( newNode )
      @nodes << newNode
    end
  end

  it "has a method for adding nodes" do
    @testGraph.respond_to?( :addNode ).should be_true
  end

  it "has a method for adding arcs" do
    @testGraph.respond_to?( :addArc ).should be_true
  end


  describe "#nodesCount" do
    it "provides an accurate count after adding nodes" do
      @growthGraph.nodesCount.should eql GRAPH_TEST_RANGE.count
    end
    it "provides an accurate initial count" do
      @testGraph.nodesCount.should eql 0
    end
  end

  describe "#new" do
    it "creates a new Graph instance" do
      @testGraph.should be_an_instance_of Graph
    end
    it "creates an empty Graph" do
      @testGraph.nodesCount.should eql 0
    end
  end

  describe "#addNode" do
    it "correctly adds elements to graph" do
      @growthGraph.nodesCount.should eql GRAPH_TEST_RANGE.count
      GRAPH_TEST_RANGE.each do |i|
        @growthGraph.containsNodeWithName?( "#{i}" ).should be_true
      end
    end
    it "does not add weird elements" do
      GRAPH_TEST_RANGE.each do |i|
        @growthGraph.containsNodeWithName?( "#{-i}" ).should be_false
      end
      @growthGraph.containsNodeWithName?( "FOO" ).should be_false
    end
  end

  describe "#containsNode?" do
    it "correctly identifies member nodes" do
      @nodes.each { |n| @growthGraph.containsNode?( n ).should be_true }
    end
    it "correctly excludes non-member nodes" do
      @nodes.each { |n| @testGraph.containsNode?( n ).should be_false }
    end
  end

  describe "#containsNodeWithName?" do
    it "correctly assembles key-value pairs keyed on string name" do
      @nodes.each do |n|
        @growthGraph.containsNodeWithName?( n.name ).should be_true
      end
      GRAPH_TEST_RANGE.each do |i|
        @growthGraph.containsNodeWithName?( "#{i}" ).should be_true
      end
    end
    it "does not give false positive for keys." do
      @nodes.each do |n|
        @testGraph.containsNodeWithName?( n.name ).should be_false
      end 
      GRAPH_TEST_RANGE.each do |i|
        @testGraph.containsNodeWithName?( "#{i}" ).should    be_false
        @growthGraph.containsNodeWithName?( "#{-i}" ).should be_false
      end
    end
  end

  describe "#nodeWithName" do
    it "correctly retrieves nodes that have been added" do
      @nodes.each { |n| @growthGraph.nodeWithName( n.name ).should equal n }
    end
    it "returns nil if the node has not been added" do
      @nodes.each { |n| @testGraph.nodeWithName( n.name ).should be_nil }
    end
  end

=begin
  describe "#nodes" do
    it "returns an array of nodes" do
      @testGraph.nodes.should   be_an_instance_of Array
      @growthGraph.nodes.should be_an_instance_of Array
      @testGraph.nodes.each   { |n| n.should be_an_instance_of Node }
      @growthGraph.nodes.each { |n| n.should be_an_instance_of Node }
    end
  end
=end

end
