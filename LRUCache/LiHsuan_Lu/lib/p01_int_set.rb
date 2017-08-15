class MaxIntSet
  def initialize(max)
    @store = Array.new(max){false}
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @store.length && num >= 0
  end

  def validate!(num)
    raise 'Out of bounds' unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num%num_buckets].push(num)
  end

  def remove(num)
    raise 'Number not found' unless include?(num)
    @store[num%num_buckets].delete(num)
  end

  def include?(num)
    @store[num%num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    @store[num%num_buckets].push(num)
    @count += 1
  end

  def remove(num)
    raise 'Number not found' unless include?(num)
    @store[num%num_buckets].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[num%num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets*2) { Array.new }
    old_store.each do |bucket|
      bucket.each do |num|
        @store[num % @store.length].push(num)
      end
    end
  end
end
