require 'graph'

class Graph

  def countRoutesWithStops( sourceName,
                            destinationName,
                            stops,
                            strict = false )
    return 0 unless ( self.containsNodeWithName?( sourceName ) &&
                      self.containsNodeWithName?( destinationName ) )

    source      = self.nodeWithName( sourceName )
    destination = self.nodeWithName( destinationName )

    return routesUntilStop( source, destination, stops, strict )
  end

  private

  def routesUntilStop( node, targetNode, stepsRemaining, strict )
    return 0 if stepsRemaining == 0

    thisStepRoutes = 0
    if stepsRemaining == 1 || !strict
      thisStepRoutes += 1 if node.adjacentTo?(targetNode)
    end

    nextStepRoutes = 0
    node.neighbours.each { |neighbour|
      nextStepRoutes += routesUntilStop( neighbour,
                                         targetNode,
                                         stepsRemaining - 1,
                                         strict )
    }
    return thisStepRoutes + nextStepRoutes
  end

end
