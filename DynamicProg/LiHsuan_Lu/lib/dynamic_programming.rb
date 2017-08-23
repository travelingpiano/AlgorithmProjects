class DynamicProgramming
  attr_reader :super_frog
  def initialize
    @blair_cache = {}
    @frog_bottom = {}
    @frog_top = {}
    @super_frog = Hash.new()
    @super_perm = {}
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
    if @frog_bottom[n]
      return @frog_bottom[n]
    end
    if n == 1
      @frog_bottom[1] = [[1]]
    elsif n == 2
      @frog_bottom[2] = [[1,1],[2]]
    elsif n == 3
      @frog_bottom[3] = [[1,1,1],[1,2],[2,1],[3]]
    else
      @frog_bottom[n] = []
      frog_hops_bottom_up(n-1).each do |el|
        el = el.dup
        @frog_bottom[n].push(el.push(1))
      end
      frog_hops_bottom_up(n-2).each do |el2|
        el2 = el2.dup
        @frog_bottom[n].push(el2.push(2))
      end
      frog_hops_bottom_up(n-3).each do |el3|
        el3 = el3.dup
        @frog_bottom[n].push(el3.push(3))
      end
    end
    @frog_bottom[n]
  end

  def frog_cache_builder(n)

  end

  def frog_hops_top_down(n)
    if @frog_top[n]
      return @frog_top[n]
    end
    @frog_top[n] = frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    if n == 1
      @frog_top[1] = [[1]]
    elsif n == 2
      @frog_top[2] = [[1,1],[2]]
    elsif n == 3
      @frog_top[3] = [[1,1,1],[1,2],[2,1],[3]]
    else
      @frog_top[n] = []
      frog_hops_top_down(n-1).each do |el|
        el = el.dup
        @frog_top[n].push(el.push(1))
      end
      frog_hops_top_down(n-2).each do |el2|
        el2 = el2.dup
        @frog_top[n].push(el2.push(2))
      end
      frog_hops_top_down(n-3).each do |el3|
        el3 = el3.dup
        @frog_top[n].push(el3.push(3))
      end
    end
    @frog_top[n]
  end

  #return all step perms given a n
  def super_perms(n)
    return @super_perm[n] if @super_perm[n]
    if n == 1
      @super_perm[1] = [[1]]
    else
      @super_perm[n] = [[n]]
      steps_left = n-1
      while steps_left > 0
        super_perms(steps_left).each do |el|
          el = el.dup
          @super_perm[n].push(el.push(n-steps_left))
        end
        steps_left -= 1
      end
    end
    @super_perm[n]
  end

  def super_frog_hops(n, k)
    unless @super_frog[k]
      @super_frog[k] = {}
    end
    if k > n
      return super_frog_hops(n,n)
    end
    return @super_frog[k][n] if @super_frog[k][n]
    #list of base cases
    if n <= k
      @super_frog[k][n] = super_perms(n)
    else
      @super_frog[k][n] = []
      steps_left = n-1
      while steps_left >= 1 && steps_left >= (n-k)
        super_frog_hops(steps_left,k).each do |el|
          el = el.dup
          @super_frog[k][n].push(el.push(n-steps_left))
        end
        steps_left -= 1
      end
    end
    @super_frog[k][n]
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
