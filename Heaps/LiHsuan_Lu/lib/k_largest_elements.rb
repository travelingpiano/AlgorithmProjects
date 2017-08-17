require_relative 'heap'

def k_largest_elements(array, k)
  end_idx = 1
  while end_idx < array.length
    end_idx += 1
    array = BinaryMinHeap.heapify_up(array[0...end_idx],end_idx-1){|a,b| -1*(a<=>b)} + array[end_idx..-1]
  end
  end_idx -= 1
  while end_idx > (array.length-k-1)
    array = BinaryMinHeap.swap(array,0,end_idx)
    array = BinaryMinHeap.heapify_down(array[0...end_idx],0){|a,b| -1*(a<=>b)} + array[end_idx..-1]
    end_idx -= 1
  end
  array[-k..-1]
end
