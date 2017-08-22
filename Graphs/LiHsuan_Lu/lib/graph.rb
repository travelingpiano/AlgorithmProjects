class Vertex
  attr_reader :value, :in_edges, :out_edges
  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end

  def add_in_edge(edge)
    @in_edges.push(edge)
  end

  def add_out_edge(edge)
    @out_edges.push(edge)
  end

  def delete_in_edge(edge)
    @in_edges.delete(edge)
  end

  def delete_out_edge(edge)
    @out_edges.delete(edge)
  end
end

class Edge
  attr_reader :from_vertex, :to_vertex, :cost
  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    @cost = cost
    @from_vertex.add_out_edge(self)
    @to_vertex.add_in_edge(self)
  end

  def destroy!
    @from_vertex.delete_out_edge(self)
    @to_vertex.delete_in_edge(self)
    @from_vertex = nil
    @to_vertex = nil
  end
end
