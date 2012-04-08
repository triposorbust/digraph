require 'node'
require 'graph'

class Node

  def adjacency_hash
    h = Hash.new
    @arcs.each { |arc|
      h.store( arc.destination.name, arc.weight )
    }
    return h
  end

end


class Graph

  def shortest_paths( name )
    h = Hash.new

    @nodes.values.each { |n| h.store( n.name, nil ) }
    if h.has_key?( name ); h[name] = 0; end
    h = djikstras!( h, @nodes.values.clone )

    return h
  end

  private

  def djikstras!( distance_hash, unvisited_nodes )
    node = priorityNode( distance_hash, unvisited_nodes )
    while node
      unvisited_nodes.delete(node)
      baseDistance = distance_hash[ node.name ]

      node.adjacency_hash.each do |name, stepDistance|
        totalDistance = baseDistance + stepDistance      
        if !distance_hash[ name ] || totalDistance < distance_hash[ name ]
          distance_hash[ name ] = totalDistance
        end
      end

      node = priorityNode( distance_hash, unvisited_nodes )
    end
    return distance_hash
  end

  def priorityNode( priorityHash, unvisitedNodes )
    sortedNodes = unvisitedNodes.sort do |a,b|
      dA = priorityHash[ a.name ]
      dB = priorityHash[ b.name ]
      ncompare( dA, dB )
    end

    best = sortedNodes[0]
    return best && priorityHash[ best.name ] ? sortedNodes[0] : nil
  end

  def ncompare( i, j ) # comparison on nullables
    if i && j
      return i.<=>( j )
    elsif !i && j
      return 1
    elsif !j && i
      return -1
    else
      return 0
    end
  end

end
