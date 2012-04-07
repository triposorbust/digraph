require 'node'

class Arc

  attr_reader :source, :dest, :weight

  def initialize source, dest, weight
    [source,dest].each do |node|
      unless node.is_a?( Node )
        raise TypeError "arcs require nodes!"
      end
      raise TypeError "weights are numeric"  unless weight.is_a? Numeric
    end
    @source = source
    @dest   = dest
    @weight = weight
  end

end
