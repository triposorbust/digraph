require 'graph'

class Graph

  def countRoutesWithStops( srcNm,
                            destNm,
                            stops,
                            strict = false )
    return 0 unless ( self.containsNodeWithName?( srcNm ) &&
                      self.containsNodeWithName?( destNm ) )

    src  = self.nodeWithName( srcNm )
    dest = self.nodeWithName( destNm )

    return routesUntilStop( src, dest, stops, strict )
  end

  private

  def routesUntilStop( nd, targetNd, stepsRemain, strict )
    return 0 if stepsRemain == 0

    success = 0
    if stepsRemain == 1 || !strict
      success = 1 if nd.adjacentTo?(targetNd)
    end

    successR = 0
    nd.neighbours.each { |neighbour|
      successR += routesUntilStop( neighbour,
                                   targetNd,
                                   stepsRemain - 1,
                                   strict )
    }
    return success + successR
  end

end
