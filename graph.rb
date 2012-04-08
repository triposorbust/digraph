require 'node'
require 'arc'

class Graph

  def initialize
    @nodes = Hash.new
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

    self.addNode(src)  if !( self.containsNode?(src) )
    self.addNode(dest) if !( self.containsNode?(dest) )
    src.addArc( dest, weight )
  end

  def containsNode?( n );          @nodes.has_value?( n ); end
  def containsNodeWithName?( nm ); @nodes.has_key?( nm );  end
  def nodesCount();                @nodes.count;           end
  def nodeWithName( nm );          @nodes[nm];             end
# def nodes();                     @nodes.values;          end 

end
