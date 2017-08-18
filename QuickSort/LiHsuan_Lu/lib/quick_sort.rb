class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    QuickSort.sort1(array.select{|el| el < array[0]}) + [array[0]] + QuickSort.sort1(array.select{|el| el > array[0]})
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    if length <= 1
      return array
    end
    prc ||= Proc.new{|a,b| a<=>b}
    mid_idx = QuickSort.partition(array,start,length,&prc)
    QuickSort.sort2!(array,start,mid_idx-start, &prc)
    QuickSort.sort2!(array,mid_idx+1,length-mid_idx-1,&prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new{|a,b| a<=>b}
    div_idx = start+1
    (start+1...start+length).each do |idx|
      if prc.call(array[idx],array[start]) == -1 #less than pivot element
        if div_idx < idx
          array = QuickSort.swap(array,div_idx,idx)
        end
        div_idx += 1
      end
    end
    div_idx -= 1
    array = QuickSort.swap(array,div_idx,start) #pivot swapped after iterating through array
    div_idx
  end

  def self.swap(array,idx1,idx2)
    temp = array[idx1]
    array[idx1] = array[idx2]
    array[idx2] = temp
    array
  end
end
