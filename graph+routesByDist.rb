require 'graph'

class Graph

  def countRoutesWithMaxDist( sourceName,
                              destinationName,
                              maxDist )
    return 0 unless ( self.containsNodeWithName?( sourceName ) &&
                      self.containsNodeWithName?( destinationName ) )

    source      = self.nodeWithName( sourceName )
    destination = self.nodeWithName( destinationName )

    return routesUntilDist( source, destination, maxDist )
  end

  private

  # HACK: initialCall is here because we don't consider 'standing still'
  #       to be a route from A to A.
  #
  #  USE: Call this as if it had three arguments. The recursive cases will
  #       handle the toggle.
  def routesUntilDist( node, targetNode, remaining, initialCall = true )
    return 0 if remaining <= 0

    success = 0
    if node.equal?( targetNode ) && !initialCall
      success = 1
    end

    successR = 0
    node.neighbours.each { |neighbour|
      successR += routesUntilDist( neighbour,
                                   targetNode,
                                   remaining - node.distanceTo(neighbour),
                                   false )
    }

    return success + successR
  end

end
