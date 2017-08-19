# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

require 'bst_node'

class BinarySearchTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def insert(value)
    #setting root if root has not been set yet
    unless @root
      @root = BSTNode.new(value)
    else
      flag = 0
      cur_node = @root
      #search where to put the node
      while flag == 0
        prev_node = cur_node
        cur_node = node_available(value,cur_node)
        #if location to place new node was found
        if prev_node == cur_node
          flag = 1
        end
      end
    end
  end

  def find(value, tree_node = @root)
    flag = 0
    cur_node = tree_node
    while cur_node != nil
      prev_node = cur_node
      cur_node = node_find(value,cur_node)
      if prev_node == cur_node
        return cur_node
      end
    end
    cur_node
  end

  def delete(value)
    cur_node = find(value)
    #set root to nil if target is root
    cur_node
    if cur_node == @root
      @root = nil
    else
      #if target node has no children
      if cur_node.left == nil && cur_node.right == nil
        no_child_delete(cur_node)
      #if target node has one child
      elsif (cur_node.left==nil) ^ (cur_node.right==nil)
        one_child_delete(cur_node)
      #if target has two children
      else
        two_children_delete(cur_node)
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    max_node = tree_node
    while max_node.right != nil
      max_node = max_node.right
    end
    max_node
  end

  def depth(tree_node = @root)
    #base case: return 1 if there are no children for the tree node
    return 0 if tree_node.left == nil && tree_node.right == nil
    if tree_node.left == nil
      return 1 + depth(tree_node.right)
    elsif tree_node.right == nil
      return 1 + depth(tree_node.left)
    else
      if depth(tree_node.left) > depth(tree_node.right)
        return 1 + depth(tree_node.left)
      else
        return 1 + depth(tree_node.right)
      end
    end
  end

  def is_balanced?(tree_node = @root)
    min_max = [depth(tree_node.left),depth(tree_node.right)].minmax
    min_max[1] <= min_max[0]
  end

  def in_order_traversal(tree_node = @root, arr = [])
    #base case if no children
    if tree_node.left == nil && tree_node.right == nil
      arr.push(tree_node.value)
      return arr
    end
    if tree_node.left == nil
      arr.push(tree_node.value)
      return in_order_traversal(tree_node.right,arr)
    elsif tree_node.right == nil
      arr = in_order_traversal(tree_node.left,arr)
      arr.push(tree_node.value)
      return arr
    else
      arr = in_order_traversal(tree_node.left,arr)
      arr.push(tree_node.value)
      arr = in_order_traversal(tree_node.right,arr)
      return arr
    end
  end


  private
  # optional helper methods go here:
  def node_available(value,cur_node)
    #if current node is at the bottom of the tree
    if value > cur_node.value && cur_node.right == nil
      node = BSTNode.new(value)
      node.parent = cur_node
      cur_node.right = node
    elsif value <= cur_node.value && cur_node.left == nil
      node = BSTNode.new(value)
      node.parent = cur_node
      cur_node.left = node
    elsif value > cur_node.value
      cur_node = cur_node.right
    else
      cur_node = cur_node.left
    end
    return cur_node
  end

  def node_find(value,cur_node)
    #two cases if not found
    if value > cur_node.value && cur_node.right == nil
      cur_node = nil
    elsif value < cur_node.value && cur_node.left == nil
      cur_node = nil
    elsif value == cur_node.value
      return cur_node
    elsif value > cur_node.value
      cur_node = cur_node.right
    else
      cur_node = cur_node.left
    end
    cur_node
  end

  def no_child_delete(cur_node)
    #find out which side the node belonged to
    if cur_node.value > cur_node.parent.value
      cur_node.parent.right = nil
    else
      cur_node.parent.left = nil
    end
  end

  def one_child_delete(cur_node)
    parent = cur_node.parent
    #see if the new node was on left or right of previous node
    if cur_node.left==nil
      cur_node = cur_node.right
    else
      cur_node = cur_node.left
    end
    #see if the node was on the left or right of parent
    cur_node.parent = parent
    if cur_node.value < parent.value
      cur_node.parent.left = cur_node
    else
      cur_node.parent.right = cur_node
    end
  end

  def two_children_delete(cur_node)
    #find max of left tree
    new_node =  maximum(cur_node.left)
    #check if new node has left child (certainly no right child by definition) and do appropriate replacement
    unless new_node.left == nil
      new_node.left.parent = new_node.parent
      new_node.parent.right = new_node.left
    else
      new_node.parent.right = nil
    end
    #replace current node, first by changing pointer of the parent
    if cur_node.value < cur_node.parent.value
      cur_node.parent.left = new_node
    else
      cur_node.parent.right = new_node
    end
    #then by changing pointer of children
    new_node.left = cur_node.left
    new_node.right = cur_node.right
    cur_node.left.parent = new_node
    cur_node.right.parent = new_node
    #for left, needs to check if the tree only had one element
    if cur_node.left == new_node
      new_node.left = nil
    else
      new_node.left = cur_node.left
      cur_node.left.parent = new_node
    end
  end
end
