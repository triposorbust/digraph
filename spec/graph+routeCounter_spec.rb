require 'spec_helper'
require 'graphFactory'
require 'graph+routeCounter'

describe Graph do

  before :each do
    @testGraph = Graph.new
    graphStr   = "AB5, BC4, CD8, DE6, AD5, CE2, EB3, AE7"
    @fullGraph = GraphFactory.buildGraph( graphStr )
  end

  it "should contain a method called countRoutesWithStops" do
    @testGraph.respond_to?( :countRoutesWithStops ).should be_true
    @fullGraph.respond_to?( :countRoutesWithStops ).should be_true
  end

  describe "#countRoutesWithStops" do
    it "should return 0 if sourceName is not in graph" do
      @testGraph.countRoutesWithStops( "A", "B", 10 ).should eql 0
      @fullGraph.countRoutesWithStops( "X", "A", 10 ).should eql 0
    end
    it "should return 0 if destinationName is not in graph" do
      @testGraph.countRoutesWithStops( "A", "B", 10 ).should eql 0
      @fullGraph.countRoutesWithStops( "A", "X", 10 ).should eql 0
    end
    it "returns the correct number of routes" do
      # to be filled in later.
    end
  end

  it "should contain a method called countRoutesWithMaxDist" do
    @testGraph.respond_to?( :countRoutesWithMaxDist ).should be_true
    @fullGraph.respond_to?( :countRoutesWithMaxDist ).should be_true
  end

  describe "#countRoutesWithMaxDist" do
    it "should return 0 if sourceName is not in graph" do
      @testGraph.countRoutesWithMaxDist( "A", "B", 30 ).should eql 0
      @fullGraph.countRoutesWithMaxDist( "X", "A", 30 ).should eql 0
    end
    it "should return 0 if destinationName is not in graph" do
      @testGraph.countRoutesWithMaxDist( "A", "B", 30 ).should eql 0
      @fullGraph.countRoutesWithMaxDist( "A", "X", 30 ).should eql 0
    end
    it "returns the correct number of routes" do
    end
  end

end

describe_internally Graph do


end
