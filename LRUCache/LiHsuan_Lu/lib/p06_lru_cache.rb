require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if !@map.include?(key)
      value = @prc.call(key)
      if count == @max
        eject!
        @map.delete(key)
      end
      @store.append(key,value)
      @map.set(key,@store.last)
    else
      update_node!(@map.get(key))
    end
    @store.last.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node.key)
    @store.append(node.key,node.val)
  end

  def eject!
    # p 'remove ' + @store.first.key.to_s
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)
    # p @store
  end
end
