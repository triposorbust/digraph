require 'spec_helper'
require 'graphFactory'

describe GraphFactory do

  class GraphFactoryTest
    include GraphFactory
  end

  before :each do
    @test = GraphFactoryTest.new
  end

  describe "buildGraph" do
    it "takes a string and returns a graph" do
      @test.buildGraph("FOO").should be_an_instance_of Graph
    end
  end


end
