require 'arc'

# class Node < Array # (of Arc)
class Node
  attr_reader :name

  def initialize( name )
    raise TypeError unless name.is_a? String
    @name = name.clone
    @name.freeze

    @arcs = Array.new
  end

  def addArc( destination, weight )
    raise TypeError "destinations are nodes" unless destination.is_a? Node
    raise TypeError "weight must be numeric" unless weight.is_a? Numeric

    @arcs << Arc.new(destination, weight)
  end

  # ANDY: Can we consolidate to a single interface?

  # adjacentTo? :: String -> Bool
  def adjacentTo?( destination )
    if destination.is_a? Node
      return arcForNode( destination ) ? true : false
    else
      return arcForName( destination ) ? true : false
    end
  end

  # arcForNode :: Node -> Arc
  def arcForNode( destinationNode )
    @arcs.detect { |a| a.destination == destinationNode }
  end

  # arcForName :: String -> Arc
  def arcForName( destinationName )
    @arcs.detect { |a| a.destination.name == destinationName }
  end

end
