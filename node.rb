require 'arc'

# class Node < Array # (of Arc)
class Node
  attr_reader :name

  def initialize( name )
    raise TypeError, "node names are strings"  unless name.is_a? String
    @name = name.clone
    @name.freeze

    @arcs = Array.new
  end

  def addArc( destination, weight )
    raise TypeError, "destinations are nodes" unless destination.is_a? Node
    raise TypeError, "weight must be numeric" unless weight.is_a? Numeric
    raise ArgumentError, "duplicate name" if ( arcForName( destination.name ) )

    @arcs << Arc.new(destination, weight)
  end

  # distanceTo :: (Num a) => Node -> Maybe a
  def distanceTo( node )
    raise TypeError, "Nodes are only linked to Nodes" unless node.is_a? Node
    if adjacentTo?( node )
      return arcForNode( node ).weight
    else
      return nil
    end
  end

  # adjacentTo? :: String -> Bool
  def adjacentTo?( destination )
    if destination.is_a? Node
      return arcForNode( destination ) ? true : false
    elsif destination.is_a? String
      return arcForName( destination ) ? true : false
    else
      raise TypeError, "destination is either a Node or a String"
    end
  end

  def neighbours
    return @arcs.map { |a| a.destination }
  end

  private

  # arcForName :: String -> Arc
  def arcForName( destinationName )
    @arcs.detect { |a| a.destination.name == destinationName }
  end

  # arcForNode :: Node -> Arc
  def arcForNode( destinationNode )
    @arcs.detect { |a| a.destination == destinationNode }
  end

end
