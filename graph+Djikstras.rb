require 'node+adjacencyHash'
require 'graph'

class Graph

  def shortestPaths( name )
    h = Hash.new

    @nodes.values.each { |n| h.store( n.name, nil ) }
    h = djikstras( h, @nodes.values.clone,
                   nodeWithName( name ), 0 )

    return h
  end

  private

  def djikstras( distance_hash,
                 unvisited_nodes,
                 node = priorityNode( distance_hash, unvisited_nodes ),
                 dist = nil )
    if node
      dist = distance_hash[ node.name ] unless dist

      updated_hash = distance_hash.clone
      node.adjacencyHash.each do |name, step|
        total = dist + step
        if !updated_hash[ name ] || total < updated_hash[ name ]
          updated_hash[ name ] = total
        end
      end

      reduced_nodes = unvisited_nodes.clone
      reduced_nodes.delete( node )

      return djikstras( updated_hash,
                        reduced_nodes )
    else
      return distance_hash
    end
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
