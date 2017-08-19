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
    if cur_node == @root
      @root = nil
    else
      #if target node has no children
      if cur_node.left == nil && cur_node.right == nil
        #find out which side the node belonged to
        if cur_node.value > cur_node.parent.value
          cur_node.parent.right = nil
        else
          cur_node.parent.left = nil
        end
      #if target node has one child
      elsif (cur_node.left==nil) ^ (cur_node.right==nil)
        parent = cur_node.parent
        if cur_node.left==nil
          cur_node = cur_node.right
        else
          cur_node = cur_node.left
        end
        cur_node.parent = parent
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
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
end
