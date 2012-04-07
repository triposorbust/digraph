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
    raise TypeError "Graphs only contain nodes" unless n.is_a? Node
    @nodes.has_key?( n.name) ? @nodes.store( n.name, n ) : @nodes[n.name]
  end

  def addArc( src, dest, weight )
    # something.
  end

end
