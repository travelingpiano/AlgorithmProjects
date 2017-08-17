class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc ||= Proc.new{|a, b| a <=> b}
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store = BinaryMinHeap.swap(@store,0,count-1)
    num = @store.pop
    BinaryMinHeap.heapify_down(@store,0,@store.length)
    num
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store,count-1,@store.length)
    @store
  end

  public
  def self.child_indices(len, parent_index)
    child_index = []
    if parent_index*2 + 2 < len
      return [parent_index*2+1,parent_index*2+2]
    elsif parent_index*2 + 1 < len
      return [parent_index*2+1]
    else
      return []
    end
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    return (child_index-1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new{|a,b| a <=> b}
    cur_idx = parent_idx
    flag = 0
    while cur_idx < len-1 && flag == 0
      #compare with child elements
      child_index = BinaryMinHeap.child_indices(len, cur_idx)
      #if both child elements are available
      if child_index.length == 2
        #if greater than one or both children
        if prc.call(array[cur_idx],array[child_index[0]]) == 1 || prc.call(array[cur_idx],array[child_index[1]]) == 1
          if prc.call(array[child_index[0]],array[child_index[1]]) == 1
            array = BinaryMinHeap.swap(array,cur_idx,child_index[1])
            cur_idx = child_index[1]
          else
            array = BinaryMinHeap.swap(array,cur_idx,child_index[0])
            cur_idx = child_index[0]
          end
        #if greater than one children
        else
          #swapping ends
          flag = 1
        end
      elsif child_index.length == 1
        if prc.call(array[cur_idx],array[child_index[0]]) == 1
          array = BinaryMinHeap.swap(array,cur_idx,child_index[0])
        end
        flag = 1
      else
        flag = 1
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new{|a,b| a <=> b}
    cur_idx = child_idx
    flag = 0
    while cur_idx > 0 && flag == 0
      parent_idx = BinaryMinHeap.parent_index(cur_idx)
      if prc.call(array[parent_idx],array[cur_idx]) == 1
        array = BinaryMinHeap.swap(array,parent_idx,cur_idx)
        cur_idx = parent_idx
      else
        flag = 1
      end
    end
    array
  end

  def self.swap(array,first_idx,second_idx)
    temp = array[second_idx]
    array[second_idx] = array[first_idx]
    array[first_idx] = temp
    return array
  end
end
