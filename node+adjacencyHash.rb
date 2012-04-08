require 'node'

class Node

  def adjacency_hash
    h = Hash.new
    @arcs.each { |arc|
      h.store( arc.destination.name, arc.weight )
    }
    return h
  end

end
