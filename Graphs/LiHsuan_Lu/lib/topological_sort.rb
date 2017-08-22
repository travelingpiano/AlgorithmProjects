require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  unless connected?(vertices) && !cyclic?(vertices)
    return []
  end
  sorted = []
  top = Queue.new
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      top.enq(vertex)
    end
  end
  until top.empty?
    current = top.pop
    sorted << current
    current.out_edges.each do |edge|
      if edge.to_vertex.in_edges[0] == edge && edge.to_vertex.in_edges.length == 1
        top.enq(edge.to_vertex)
      else
        edge.to_vertex.delete_in_edge(edge)
      end
    end
  end
  sorted
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
    found[start_idx].in_edges.each do |edge|
      unless found.include?(edge.from_vertex)
        found.push(edge.from_vertex)
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
    start_idx = 0
    while start_idx < found.length
      found[start_idx].out_edges.each do |edge|
        if vertex == edge.to_vertex
          return true
        elsif !found.include?(edge.to_vertex)
          found.push(edge.to_vertex)
        end
      end
      start_idx += 1
    end
  end
  false
end
