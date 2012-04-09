require 'spec_helper'
require 'graphFactory'
require 'graph+routesByStops'

describe Graph do

  before :each do
    @testGraph = Graph.new
    graphStr   = "AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7"
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
      @fullGraph.countRoutesWithStops( "C", "C", 3, false ).should eql 2
      @fullGraph.countRoutesWithStops( "A", "C", 4, true ).should eql 3
    end
  end

end

describe_internally Graph do

  before :each do
    @testGraph = Graph.new
    graphStr   = "AB5, BC4, CD8, DC8,  DE6, AD5, CE2, EB3, AE7"
    @fullGraph = GraphFactory.buildGraph( graphStr )
  end

  it "contains a method called routesUntilStop" do
    @testGraph.respond_to?( :routesUntilStop ).should be_true
    @fullGraph.respond_to?( :routesUntilStop ).should be_true
  end

  describe "#routesUntilStop" do
    it "returns 0 if the steps remaining is zero" do
      @testGraph.routesUntilStop( Node.new( "Foo" ),
                                  Node.new( "Bar" ),
                                  0,
                                  true ).should eql 0
      @testGraph.routesUntilStop( Node.new( "Foo" ),
                                  Node.new( "Bar" ),
                                  0,
                                  false ).should eql 0
    end
    it "correctly returns non-strict route counts" do
      a = @fullGraph.nodeWithName( "A" )
      b = @fullGraph.nodeWithName( "B" )
      c = @fullGraph.nodeWithName( "C" )
      @fullGraph.routesUntilStop( a, b, 1, false ).should eql 1
      @fullGraph.routesUntilStop( a, b, 2, false ).should eql 2
      @fullGraph.routesUntilStop( a, b, 3, false ).should eql 3
      @fullGraph.routesUntilStop( a, b, 4, false ).should eql 5
      @fullGraph.routesUntilStop( c, c, 3, false ).should eql 2
    end
    it "correctly returns strict route counts" do
      a = @fullGraph.nodeWithName( "A" )
      c = @fullGraph.nodeWithName( "C" )
      e = @fullGraph.nodeWithName( "E" )
      @fullGraph.routesUntilStop( a, c, 4, true ).should eql 3
      @fullGraph.routesUntilStop( a, e, 3, true ).should eql 2
      @fullGraph.routesUntilStop( a, e, 4, true ).should eql 3
    end
  end

end
