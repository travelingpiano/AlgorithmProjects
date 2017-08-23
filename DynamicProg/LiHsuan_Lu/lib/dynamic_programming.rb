class DynamicProgramming

  def initialize
    @blair_cache = {}
    @frog_bottom = {}
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    if n == 1
      @blair_cache[1] = 1
    elsif n == 2
      @blair_cache[2] = 2
    else
      @blair_cache[n] = blair_nums(n-1) + blair_nums(n-2) + 2*(n-1) - 1
    end
    @blair_cache[n]
  end

  def frog_hops_bottom_up(n)
    return @frog_bottom[n] if @frog_bottom[n]
    if n == 1
      @frog_bottom[1] = [[1]]
    elsif n == 2
      @frog_bottom[2] = [[1,1],[2]]
    elsif n == 3
      @frog_bottom[3] = [[1,1,1],[1,2],[2,1],[3]]
    else
      @frog_bottom[n] = []
      frog_hops_bottom_up(n-1).each do |el|
        @frog_bottom[n].push(el.push(1))
      end
      frog_hops_bottom_up(n-2).each do |el|
        @frog_bottom[n].push(el.push(2))
      end
      frog_hops_bottom_up(n-3).each do |el|
        @frog_bottom[n].push(el.push(3))
      end
    end
    p n
    p @frog_bottom[n]
    @frog_bottom[n]
  end

  def frog_cache_builder(n)

  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
