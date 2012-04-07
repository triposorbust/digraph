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

  def adjacentTo?( destinationName )
    if arcs.detect { |a| a.name == destinationName }
      return true
    else
      return false
    end
  end

end
