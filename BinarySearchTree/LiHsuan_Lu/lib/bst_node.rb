class BSTNode
  attr_accessor :value, :parent, :left, :right
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end
end
