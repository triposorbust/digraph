require 'graph'

module GraphFactory

  # buildGraph :: String -> Graph
  def buildGraph( str )
    return Graph.new
  end

  def getWeight( str )
    numStr = str[/[\d,\.]+$/]
    num = numStr.nil? ? 0 : numStr.to_f
  end

  def getNames( str )
    str.scan( /[A-Z]{1}[a-z,0-9,_,\-]*/ )
  end

end
