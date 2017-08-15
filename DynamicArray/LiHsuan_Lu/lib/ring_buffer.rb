require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = Array.new(8)
    @start_idx = 0
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    if index >= length
      raise 'index out of bounds'
    end
    @store[(@start_idx+index) % capacity]
  end

  # O(1)
  def []=(index, val)
    @store[(@start_idx+index) % capacity] = val
  end

  # O(1)
  def pop
    if length == 0
      raise 'index out of bounds'
    end
    value = @store[(@start_idx+@length-1) % @capacity]
    @length -= 1
    value
  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity
      resize!
    end
    new_idx = (@start_idx + @length) % @capacity
    @store[new_idx] = val
    @length += 1
    @store
  end

  # O(1)
  def shift
    if length == 0
      raise 'index out of bounds'
    end
    old_idx = @start_idx
    @start_idx = (@start_idx+1) % @capacity
    @length -= 1
    @store[old_idx]
  end

  # O(1) ammortized
  def unshift(val)
    if length == @capacity
      resize!
    end
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
    @store
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    old_store = @store.dup
    @capacity = @capacity*2
    @store = Array.new(@capacity)
    old_store.each_index do |idx|
      @store[(@start_idx+idx) % (@capacity/2)] = old_store[idx]
    end
    @start_idx = 0
  end
end
