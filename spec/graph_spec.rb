require 'spec_helper'
require 'graph'

describe Graph do

  before :each do
    @testGraph = Graph.new
  end

  describe "#nodes" do
    it "returns an array of nodes" do
      @testGraph.nodes.should be_an_instance_of Array
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
  
  


end
