require 'spec_helper'
require 'node'
require 'arc'

describe "#new" do

  before :each do
    @arc = Arc.new( Node.new( "A" ),
                    Node.new( "B" ),
                    10 )
  end

  describe "#new" do
    it "takes three arguments and returns an arc instance" do
      @arc.should be_an_instance_of Arc
    end
  end

  describe "#source" do
    it "returns a Node" do
      @arc.source.should be_an_instance_of Node
    end
    it "returns the Source Node" do
      @arc.source.name.should eql "A"
    end
  end

  describe "#dest" do
    it "returns a Node" do
      @arc.dest.should be_an_instance_of Node
    end
    it "returns the Destination Node" do
      @arc.dest.name.should eql "B"
    end
  end

  describe "#weight" do
    it "returns the weight of the Arc" do
      @arc.weight.should eql 10
      end
  end

end
