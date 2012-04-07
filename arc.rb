require 'node'

class Arc
  # Arcs always originate in the parent Node.
  attr_reader :destination, :weight

  def initialize destination, weight
    raise TypeError, "arcs must link to node" unless destination.is_a? Node
    raise TypeError, "weight must be numeric" unless weight.is_a? Numeric

    @destination = destination
    @weight      = weight
  end

end
