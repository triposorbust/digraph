require 'graph'

module GraphFactory

  # buildGraph :: String -> Graph
  def GraphFactory.buildGraph( str )
    graph = Graph.new

    arcWords  = str.gsub( "," , "" ).split
    arcHashes = arcWords.map { |w| hashify w }
    arcHashes.each { |h|
      sourceNode      = nodeForName( graph, h[:source] )
      destinationNode = nodeForName( graph, h[:destination] )
      graph.addArc( sourceNode, destinationNode, h[:weight] )
    }

    return graph
  end

  private

  def GraphFactory.nodeForName( graph, name )
    node = nil
    if graph.containsNodeWithName?( name )
      node = graph.nodeWithName( name )
    else
      node = Node.new( name )
      graph.addNode( node )
    end
    node
  end

  def GraphFactory.hashify( str )
    hash   = Hash.new
    weight = getWeight( str )
    names  = getNames( str )
    raise ArgumentError, "poorly formatted input" unless names.count == 2
    
    hash.store( :source, names[0] )
    hash.store( :destination, names[1] )
    hash.store( :weight, weight   )

    return hash
  end

  def GraphFactory.getWeight( str )
    numStr = str[/[\d,\.]+$/]
    num = numStr.nil? ? 0 : numStr.to_f
  end

  def GraphFactory.getNames( str )
    str.scan( /[A-Z]{1}[a-z,_,\-]*/ )
  end

end
