require 'spec_helper'
require 'graphFactory'
require 'graph+routesByDist'

describe Graph do

  before :each do
    @testGraph = Graph.new
    graphStr   = "AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7"
    @fullGraph = GraphFactory.buildGraph( graphStr )
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
      @fullGraph.countRoutesWithMaxDist( "C", "C", 30 ).should eql 7
    end
  end

end

describe_internally Graph do

  before :each do
    @testGraph = Graph.new
    graphStr   = "AB5, BC4, CD8, DC8,  DE6, AD5, CE2, EB3, AE7"
    @fullGraph = GraphFactory.buildGraph( graphStr )
  end

  it "contains a method called routesUntilDist" do
    @testGraph.respond_to?( :routesUntilDist ).should be_true
    @fullGraph.respond_to?( :routesUntilDist ).should be_true
  end

  describe "#routesUntilDist" do
    it "returns 0 for negative remaining distances" do
      @fullGraph.routesUntilDist( Node.new("Foo"),
                                  Node.new("Bar"),
                                  -1 ).should eql 0
      @fullGraph.routesUntilDist( Node.new("Foo"),
                                  Node.new("Bar"),
                                  -10 ).should eql 0
    end
    it "retursn 0 for 0 remaining distances at non-target node" do
      a = @fullGraph.nodeWithName( "A" )
      b = @fullGraph.nodeWithName( "B" )
      @fullGraph.routesUntilDist( a, b, 0 ).should eql 0
      @fullGraph.routesUntilDist( b, a, 0 ).should eql 0
    end
    it "recursive call returns 1 for positive distances at target node" do
      a = @fullGraph.nodeWithName( "A" )
      b = @fullGraph.nodeWithName( "B" )
      @fullGraph.routesUntilDist( a, a, 1 ).should eql 1
      @fullGraph.routesUntilDist( b, b, 1 ).should eql 1
    end
    it "initial call returns 0 for too-small positive distances at target" do
      a = @fullGraph.nodeWithName( "A" )
      b = @fullGraph.nodeWithName( "B" )
      @fullGraph.routesUntilDist( a, a, 1 ).should eql 0
      @fullGraph.routesUntilDist( b, b, 1 ).should eql 0
    end
    it "returns correct route counts for searches" do
      c = @fullGraph.nodeWithName( "C" )
      @fullGraph.routesUntilDist( c, c, 30 ).should eql 7
    end
  end

end
