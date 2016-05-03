require "./manufacturer"
require "./instances"

class Carriage
  include Manufacturer
  include Instances

  def initialize
    add(self)
  end

  def free_space
    0
  end
end
