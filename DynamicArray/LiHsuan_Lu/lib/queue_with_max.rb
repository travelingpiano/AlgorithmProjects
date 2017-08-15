# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = Array.new(8)
    @length = 0
    @max = 0
  end

  def enqueue(val)
    if @length == @store.length
      old_store = @store.dup
      @store = Array.new(@length*2)
      old_store.each_index do |idx|
        @store[idx] = old_store[idx]
      end
    end
    @store[@length] = Array.new(2)
    @store[@length] = val
    @length += 1
    return @store
  end

  def dequeue
    if @length == 0
      raise 'index out of bounds'
    end
    old_store = @store.dup
    old_store[1..-1].each_index do |idx|
      @store[idx] = old_store[idx+1]
    end
    @length -= 1
    @store
  end

  def max
    @max = @store[0...@length].max
  end

  def length
    @length
  end

end
