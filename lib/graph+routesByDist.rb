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

  def routesUntilDist( nd, targetNd, remaining )
    return 0 if remaining <= 0

    success = 0

    if nd.adjacentTo?( targetNd ) && nd.distanceTo( targetNd ) < remaining
      success = 1
    end

    successR = 0
    nd.neighbours.each { |neighbour|
      successR += routesUntilDist( neighbour,
                                   targetNd,
                                   remaining - nd.distanceTo( neighbour ) )
    }

    return success + successR
  end

end
