require 'node+adjacencyHash'
require 'graph'

class Graph

  def countRoutesWithStops( sourceName,
                            destinationName,
                            stops,
                            strict = false )
    return 0 unless ( self.containsNodeWithName?( sourceName ) &&
                      self.containsNodeWithName?( destinationName ) )
    return 0
  end

  def countRoutesWithMaxDist( sourceName,
                              destinationName,
                              maxDist )
    return 0 unless ( self.containsNodeWithName?( sourceName ) &&
                      self.containsNodeWithName?( destinationName ) )
    return 0
  end

  private

end
