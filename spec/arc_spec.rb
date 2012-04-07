require 'spec_helper'
require 'arc'

describe Arc do

  before :each do
    @arc = Arc.new( Node.new( "foo" ), 10 )
  end

  describe "#new" do
    it "takes two arguments and returns an arc instance" do
      @arc.should be_an_instance_of Arc
    end
  end

  describe "#destination" do
    it "returns a Node" do
      @arc.destination.should be_an_instance_of Node
    end
    it "returns the Destination Node" do
      @arc.destination.name.should eql "foo"
    end
  end

  describe "#weight" do
    it "returns the weight of the Arc" do
      @arc.weight.should eql 10
      end
    it "has a mutable copy of weight" do
      (1..10).each { |w|
        @arc.weight = w
        @arc.weight.should eql w
      }
    end
  end

end
