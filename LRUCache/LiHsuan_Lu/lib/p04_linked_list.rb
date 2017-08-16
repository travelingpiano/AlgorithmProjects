class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = nil
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head
  end

  def last
    cur_node = @head
    cur_node = cur_node.next while cur_node.next
    cur_node
  end

  def empty?
    !@head
  end

  def get(key)
    cur_node = @head
    while cur_node
      return cur_node.val if cur_node.key == key
      cur_node = cur_node.next
    end
    nil
  end

  def include?(key)
    cur_node = @head
    while cur_node
      return true if cur_node.key == key
      cur_node = cur_node.next
    end
    false
  end

  def append(key, val)
    if @head
      cur_node = @head
      cur_node = cur_node.next while cur_node.next
      new_node = Node.new(key,val)
      cur_node.next = new_node
      new_node.prev = cur_node
    else
      @head = Node.new(key,val)
    end
  end

  def update(key, val)
    cur_node = @head
    cur_node = cur_node.next while cur_node && cur_node.key != key
    #if current node is found
    if cur_node
      cur_node.key = key
      cur_node.val = val
    end
  end

  def remove(key)
    cur_node = @head
    cur_node = cur_node.next while cur_node.next && cur_node.key != key
    if cur_node.key == key #if it was found
      if !cur_node.prev #if it's the head
        @head = @head.next
      elsif !cur_node.next #if it's the last node
        cur_node.prev.next = nil
      else #if it's something in the middle
        prev_node = cur_node.prev
        next_node = cur_node.next
        prev_node.next = next_node
        next_node.prev = prev_node
      end
    end
  end

  def each(&prc)
    cur_node = @head
    while cur_node
      prc.call(cur_node)
      cur_node = cur_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
