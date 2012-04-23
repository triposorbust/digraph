require 'graph'

class Graph

  def countRoutesWithMaxDist( srcNm,
                              destNm,
                              maxDist )
    return 0 unless ( self.containsNodeWithName?( srcNm ) &&
                      self.containsNodeWithName?( destNm ) )

    src  = self.nodeWithName( srcNm )
    dest = self.nodeWithName( destNm )

    return routesUntilDist( src, dest, maxDist )
  end

  private

  # HACK: initialCall is here because we don't consider 'standing still'
  #       to be a route from A to A.
  #
  #  USE: Call this as if it had three arguments. The recursive cases will
  #       handle the toggle.
  def routesUntilDist( nd, targetNd, remaining, initialCall = true )
    return 0 if remaining <= 0

    success = 0
    if nd.equal?( targetNd ) && !initialCall
      success = 1
    end

    successR = 0
    nd.neighbours.each { |neighbour|
      successR += routesUntilDist( neighbour,
                                   targetNd,
                                   remaining - nd.distanceTo( neighbour ),
                                   false )
    }

    return success + successR
  end

end
