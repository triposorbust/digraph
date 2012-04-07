require 'arc'

# ANDY: is this cleaner if it inherits from array?
# Node < Array
class Node
  attr_reader :name, :arcs

  def initialize( name )
    @name = name
    @arcs = Array.new
  end

  def addArc( destination, weight )
    # ANDY: these checks are redundant.
    raise TypeError "destinations are nodes" unless destination.is_a? Node
    raise TypeError "weight must be numeric" unless weight.is_a? Numeric

    @arcs << Arc.new(destination, weight)
  end

  # ANDY: interact through names or through objects?
  #       decide on an interface. Shouldn't need both.

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
