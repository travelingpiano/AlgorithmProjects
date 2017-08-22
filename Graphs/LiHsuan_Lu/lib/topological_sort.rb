require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  unless connected?(vertices) && !cyclic?(vertices)
    return []
  end
end

def connected?(vertices)
  start_idx = -1
  cur_idx = 0
  while start_idx == -1
    if vertices[cur_idx].in_edges == []
      start_idx = cur_idx
    elsif cur_idx == vertices.length - 1
      return false
    else
      cur_idx += 1
    end
  end

  #do bfs and see if we reach entire set
  found = [vertices[start_idx]]
  vertices[start_idx].out_edges.each do |edge|
    unless found.include?(edge.to_vertex)
      found.push(edge.to_vertex)
    end
  end
  start_idx = 1
  while start_idx < found.length
    printed = []
    found.each do |el|
      printed.push(el.value)
    end
    if found.length == vertices.length
      return true
    end
    found[start_idx].out_edges.each do |edge|
      unless found.include?(edge.to_vertex)
        found.push(edge.to_vertex)
      end
    end
    start_idx += 1
  end
  false
end

def cyclic?(vertices)
  #check if it's a cyclic set
  vertices.each do |vertex|
    found = []
    vertex.out_edges.each do |edge|
      unless found.include?(edge.to_vertex)
      found.push(edge.to_vertex)
      end

    end

  end
end
