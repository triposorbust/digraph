require 'spec_helper'
require 'graphFactory'

describe GraphFactory do

  class GraphFactoryTest
    include GraphFactory
  end

  before :each do
    @test = GraphFactoryTest.new
  end

  describe "#buildGraph" do
    it "takes a string and returns a graph" do
      @test.buildGraph("FooBar").should be_an_instance_of Graph
    end
  end

  describe "#getWeight" do
    it "returns 0 if there are no digits at end" do
      @test.getWeight( "foo" ).should eql 0
      @test.getWeight( "" ).should    eql 0
      @test.getWeight( "75f" ).should eql 0
    end
    it "retrieves the last digit" do
      @test.getWeight( "foo7" ).should     eql 7.0
      @test.getWeight( "foo3foo7" ).should eql 7.0
    end
    it "retrives the ending digits" do
      @test.getWeight( "foo74" ).should      eql 74.0
      @test.getWeight( "foo43foo92" ).should eql 92.0
    end
    it "retrives the last digits and decimal point" do
      @test.getWeight( "foo7.55" ).should eql  7.55
      @test.getWeight( "fo.o0.15" ).should eql 0.15
    end
    it "only keeps the first decimal encountered" do
      @test.getWeight( "foo7.5.5" ).should eql       7.5
      @test.getWeight( "foo.192.168.0.1").should eql 0.192
    end
  end

  describe "#getNames" do
    it "returns an array" do
      @test.getNames( "AB" ).should be_an_instance_of Array
    end
    it "returns an empty list for empty string" do
      @test.getNames( "" ).should be_an_instance_of Array
      @test.getNames( "" ).should be_empty
    end
    it "splits at capital letters" do
      @test.getNames( "AB" ).should be_an_instance_of Array
      @test.getNames( "AB" ).count.should eql 2
    end
    it "correctly populates name list" do
      @test.getNames( "AB" )[0].should eql "A"
      @test.getNames( "AB" )[1].should eql "B"
    end
    it "allow multiple lower case letters" do
      @test.getNames( "AaaBbb" )[0].should eql "Aaa"
      @test.getNames( "AaaBbb" )[1].should eql "Bbb"
      @test.getNames( "FooBar" )[0].should eql "Foo"
      @test.getNames( "FooBar" )[1].should eql "Bar"
    end
    it "allows underscores" do
      @test.getNames( "F_ooB_ar" )[0].should eql "F_oo"
      @test.getNames( "F_ooB_ar" )[1].should eql "B_ar"
    end
    it "allows hyphens" do
      @test.getNames( "F-o-oB-a-r" )[0].should eql "F-o-o"
      @test.getNames( "F-o-oB-a-r" )[1].should eql "B-a-r"
    end
  end

  describe "#hashify" do
    it "returns a hash" do
      @test.hashify( "WaffleIron" ).should be_an_instance_of Hash
    end
    it "returns hash with source key" do
      @test.hashify( "WaffleIron" ).has_key?( :source ).should be_true
    end
    it "returns hash with destination key" do
      @test.hashify( "WaffleIron" ).has_key?( :destination ).should be_true
    end
    it "returns hash with weight key" do
      @test.hashify( "WaffleIron" ).has_key?( :weight ).should be_true
    end
    it "properly parses toy inputs" do
      h = @test.hashify( "WaffleIron8" )
      h[:source].should      eql "Waffle"
      h[:destination].should eql "Iron"
      h[:weight].should      eql 8.0
    end
    it "properly parses sample inputs" do
      h = @test.hashify( "AB10" )
      h[:source].should      eql "A"
      h[:destination].should eql "B"
      h[:weight].should      eql 10.0
    end    
  end

  describe "#nodeForName" do
    g    = Graph.new
    node = nil
    it "returns a node" do
      node = @test.nodeForName( g, "Foo" )
      node.should be_an_instance_of Node
    end
    it "returns a node with the correct name" do
      node.name.should eql "Foo"
    end
    it "adds it to the graph upon retrieval" do
      g.containsNodeWithName?( "Foo" ).should be_true
      g.containsNode?( node ).should          be_true
    end
    it "returns the same node on repeat" do
      @test.nodeForName( g, "Foo" ).should equal node
    end
  end

end
