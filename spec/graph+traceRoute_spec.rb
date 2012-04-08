require 'graphFactory' # to build test graphs.
require 'graph+traceRoute'

describe Graph do

  before :each do
    @testGraph = Graph.new
    graphStr   = "AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7"
    @fullGraph = GraphFactory.buildGraph( graphStr )
  end

  it "contains a method called traceRoute" do
    @testGraph.respond_to?( :traceRoute ).should be_true
    @fullGraph.respond_to?( :traceRoute ).should be_true
  end

  describe "#traceRoute" do
    it "returns nil if a node w/ name is not in graph" do
      @testGraph.traceRoute( "A" ).should   be_nil
      @fullGraph.traceRoute( "Foo" ).should be_nil
    end
    it "returns nil if no such route exists" do
      @fullGraph.traceRoute( "A", "E", "D" ).should be_nil
      @fullGraph.traceRoute( "A", "B", "E" ).should be_nil
    end
    it "returns the correct distance for routes" do
      @fullGraph.traceRoute( "A", "B", "C" ).should       eql  9.0
      @fullGraph.traceRoute( "A", "D" ).should            eql  5.0
      @fullGraph.traceRoute( "A", "D", "C" ).should       eql 13.0
      @fullGraph.traceRoute( "A","E","B","C","D" ).should eql 22.0
    end
  end

end

describe_internally Graph do

  before :each do
    @testGraph = Graph.new
    graphStr   = "AB5, BC4, CD8, DE6, AD5, CE2, EB3, AE7"
    @fullGraph = GraphFactory.buildGraph( graphStr )
  end

  it "has a helper method called tracer" do
    @testGraph.respond_to?( :tracer ).should be_true
    @fullGraph.respond_to?( :tracer ).should be_true
  end

  describe "#tracer" do
    it "return the second argument when passed an empty list" do
      @testGraph.tracer( Array.new, 5 ).should  eql  5
      @testGraph.tracer( Array.new, -1 ).should eql -1
    end
    it "returns the second argument when passed a singleton" do
      @testGraph.tracer( [Node.new( "Foo" )], 5 ).should  eql  5
      @testGraph.tracer( [Node.new( "Foo" )], -1 ).should eql -1
    end
    it "returns nil when the second argument is nil" do
      testArray = Array.new
      @testGraph.tracer( testArray, nil ).should be_nil
      testArray << Node.new( "Foo" )
      @testGraph.tracer( testArray, nil ).should be_nil
      testArray << Node.new( "Bar" )
      @testGraph.tracer( testArray, nil ).should be_nil
    end
    it "adds the arc length between nodes to the accumulator" do
      # AB = 5
      a = @fullGraph.nodeWithName( "A" )
      b = @fullGraph.nodeWithName( "B" )
      @fullGraph.tracer( [a,b], 5 ).should eql 10.0
      @fullGraph.tracer( [a,b], 0 ).should eql 5.0
    end
  end

end
