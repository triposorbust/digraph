require 'spec_helper'
require 'graph'

describe Graph do

  before :all do
    @testGraph = Graph.new
  end

  describe "#new" do
    it "creates a new Graph instance" do
      @testGraph.should be_an_instance_of Graph
    end
  end


end
