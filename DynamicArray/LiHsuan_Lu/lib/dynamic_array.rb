require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = Array.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    if @length == 0 || index >= @length
      raise "index out of bounds"
    end
    @store[index]
  end

  # O(1)
  def []=(index, value)
    if @length == 0 || index > @length
      raise "index out of bounds"
    end
    @store[index] = value
  end

  # O(1)
  def pop
    if @length > 0
      answer = @store[@length-1]
      @length -= 1
      return answer
    else
      raise 'index out of bounds'
    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity
      old_store = @store.dup
      @store = Array.new(@capacity*2)
      @capacity = @capacity*2
      old_store.each do |el|
        @store.push(el)
      end
    end
    @store[@length] = val
    @length += 1
    return @store.slice(0,@length)
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0
      raise 'index out of bounds'
    end
    old_store = @store.dup
    @length -= 1
    old_store[1..-1].each_with_index do |el, idx|
      @store[idx] = old_store[idx+1]
    end
    return old_store[0]
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    old_store = @store.dup
    if @length == @capacity
      @store = Array.new(@capacity*2)
      @capacity = @capacity*2
    end
    @length += 1
    old_store.each_with_index do |el, idx|
      @store[idx+1] = el
    end
    @store[0] = val
    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
  end
end
