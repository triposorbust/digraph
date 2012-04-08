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
      @test.buildGraph("FOO").should be_an_instance_of Graph
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

end
