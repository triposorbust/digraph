require 'node'
require 'arc'

# class Graph < Hash # of String, Node
class Graph

  def initialize
    @nodes = Hash.new
  end

  def nodes
    @nodes.values
  end

  def addNode( n )
    raise TypeError, "Graph can only add nodes" unless n.is_a? Node
    raise ArgumentError, "redundant node names" if @nodes.has_key?( n.name )

    @nodes.store( n.name, n )
  end

  def addArc( src, dest, weight )
    raise TypeError, "weights must be numeric"    unless weight.is_a? Numeric
    raise TypeError, "source must be a node"      unless src.is_a?    Node
    raise TypeError, "destination must be a node" unless dest.is_a?   Node

    src.addArc( dest, weight )
  end

end
