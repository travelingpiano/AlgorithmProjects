require 'binary_search_tree'
def kth_largest(tree_node, k)
  checked = {}
  count = 0
  cur_node = tree_node
  while count < k
    cur_node = tree_node
    flag = 0
    until flag == 1
      #we know we've reached the current maximum if the all right nodes are either missing or have been checked and we have not been checked yet
      if (cur_node.right == nil || checked[cur_node.right.value]) && !checked[cur_node.value]
        flag = 1
      #if current node has been checked, all nodes right of it will have been checked also
      elsif checked[cur_node.value]
        cur_node = cur_node.left
      else
        cur_node = cur_node.right
      end
    end
    checked[cur_node.value] = true
    count += 1
  end
  return cur_node
end
