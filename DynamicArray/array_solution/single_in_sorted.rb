#[1,1,2,2,3,4,4] => 3
def single_in_sorted(arr)
  return arr[0] if arr.length == 1
  mid_index = arr.length/2
  if arr[mid_index] != arr[mid_index-1] && arr[mid_index] != arr[mid_index+1]
    return arr[mid_index]
  elsif (arr[mid_index] != arr[mid_index+1] && mid_index%2 == 1) || (arr[mid_index] != arr[mid_index-1] && mid_index%2 == 0)
    return single_in_sorted(arr[mid_index..-1])
  else
    return single_in_sorted(arr[0..mid_index])
  end
end

p single_in_sorted([1,1,2,2,3,3,4,4,5])
p single_in_sorted([1,1,2])
p single_in_sorted([1,1,2,2,3])
