require 'graph'

class Graph

  def traceRoute( *names )
    return nil if names.detect { |name| !( self.containsNodeWithName? name ) }
    nodes = names.map { |name| self.nodeWithName( name ) }
    return traceR( nodes, 0 )
  end

  private

  # traceR :: (Num a) => [Node] -> Maybe a
  def traceR( nodes, acc )
    if !acc || nodes.count <= 1
      return acc # base cases for failure / success
    else
      head = nodes.slice!(0)
      step = head.distanceTo( nodes[0] )

      acc  = step ? ( acc + step ) : nil
      return traceR( nodes, acc )
    end
  end

end
