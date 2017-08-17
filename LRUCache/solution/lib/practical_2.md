## Problem
This is a two part problem:
1. First, write a series of instructions on how to build out an LRU Cache (pretend
the person you're writing to has no idea how to build one. Don't forget to address
the reasoning behind using particular data structures).
2. Implement an LRU Cache from scratch with no outside references. **Don't look
at the code or instructions from your homework!**

## Solution

### Part 1
Write first part here:
1. To allow us to perform insert, remove and get operations all in O(1) time
2. Combines a linked list with a hash map, a hash map for the O(1) operations and a linked list so we know what element to remove when we have met the capacity of the cache
3. Append node into linked list and insert it into hash map if node is not present. The key, value pair in the hash map will be the key of the node and a pointer to the node in the linked list. The key, value pair in the linked list will be the key of the node and value of the node respectively.
4. If the cache is at maximum capacity,

### Part 2
```ruby
class LRUCache
end
```
