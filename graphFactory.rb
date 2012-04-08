require 'graph'

module GraphFactory

  # buildGraph :: String -> Graph
  def buildGraph( str )
    graph = Graph.new

    str.split.map!{ |w| # words
      self.hashify w
    }.each{ |h| # arc hashes
      sn = self.nodeForName( graph, h[:source] )
      dn = self.nodeForName( graph, h[:destination] )
      graph.addArc( sn, dn, h[:weight] )
    }

    return graph
  end

  def nodeForName( graph, name )
    node = nil
    if graph.containsNodeWithName?( name )
      node = graph.nodeWithName( name )
    else
      node = Node.new( name )
      graph.addNode( node )
    end
    node
  end

  def hashify( str )
    hash   = Hash.new
    weight = self.getWeight( str )
    names  = self.getNames( str )
    raise ArgumentError, "poorly formatted input" unless names.count == 2
    
    hash.store( :source, names[0] )
    hash.store( :destination, names[1] )
    hash.store( :weight, weight   )

    return hash
  end

  def getWeight( str )
    numStr = str[/[\d,\.]+$/]
    num = numStr.nil? ? 0 : numStr.to_f
  end

  def getNames( str )
    str.scan( /[A-Z]{1}[a-z,_,\-]*/ )
  end

end
