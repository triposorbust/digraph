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

end
