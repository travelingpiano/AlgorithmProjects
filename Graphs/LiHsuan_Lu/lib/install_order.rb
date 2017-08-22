# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to



def install_order(arr)
  #search for nodes with no dependencies
  #first, search for max_id
  max = arr.flatten.max
  solutions = []
  (1..max).to_a.each do |num|
    solutions.push(num) unless arr.flatten.include?(num)
  end
  #make the graph
  found = []
  vertices_arr = []
  arr.each do |dependency|
    new_el = []
    if found.find_index{|el| el.value == dependency[0]}
      new_el.push(found[found.find_index{|el| el.value == dependency[0]}])
    else
      new_vertex = Vertex.new(dependency[0])
      found.push(new_vertex)
      new_el.push(new_vertex)
    end
    if found.find_index{|el| el.value == dependency[1]}
      new_el.push(found[found.find_index{|el| el.value == dependency[1]}])
    else
      new_vertex = Vertex.new(dependency[1])
      found.push(new_vertex)
      new_el.push(new_vertex)
    end
    vertices_arr.push(new_el)
  end
  vertices_arr.each do |vertices|
    new_edge = Edge.new(vertices[1],vertices[0])
  end
  ans = topological_sort(found)
  sol = []
  ans.each do |vertex|
    sol << vertex.value
  end
  sol.concat(solutions)
end
