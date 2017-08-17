require_relative "heap"

class Array
  def heap_sort!
    end_idx = 1
    arr = self.dup
    #get a max heap
    while end_idx < self.length
      end_idx += 1
      arr = BinaryMinHeap.heapify_up(arr[0...end_idx],end_idx-1){|a,b| -1*(a<=>b)} + arr[end_idx..-1]
    end
    end_idx -= 1
    #reverse the order and extract max element one by one
    while end_idx > 0
      arr = BinaryMinHeap.swap(arr,0,end_idx)
      arr = BinaryMinHeap.heapify_down(arr[0...end_idx],0){|a,b| -1*(a<=>b)} + arr[end_idx..-1]
      end_idx -= 1
    end
    self.replace(arr)
  end
end
