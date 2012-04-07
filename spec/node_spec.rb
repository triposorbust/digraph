require 'spec_helper'
require 'node'

describe Node do

  before :each do
    @testnode = Node.new "Test"
  end

  describe "#new" do
    it "takes one parameter and returns a Node instance" do
      @testnode.should be_an_instance_of Node
    end
  end

  describe "#name" do
    it "returns correct node name" do
      @testnode.name.should eql "Test"
    end
  end

end
