
class MazeSolver

  def initialize(maze)
    @maze = maze # maze array read from file
    @path = [] #solution path
    @start = self.parse # x,y of starting cell
  end

  # find x,y of starting cell marked with S
  def parse
    start_x = 0
    start_y = 0

    @maze.each_with_index do |line, index|
      if line.include? 'S'
        start_y = line.index('S')
        start_x = index
        break
      end
    end
    [start_x, start_y]
  end

  def solve
    queue = []
    exit = false
    cell = Cell.new(nil, nil, nil)

    # enqueue first cell
    queue << Cell.new(@start.first, @start.last, cell)

    while !queue.empty? and !exit
      cell = queue.pop

      x = cell.x
      y = cell.y

      if is_exit?(cell)
        exit = true
      else
        # if exit is not found
        # mark cell as visited
        # and find next cells to add to the queue
        mark_visited!(x, y)
        queue = enqueue_next_cell(cell, queue)  
      end
    end

    if exit
      # traverse all solution cells by getting its parent
      while cell.parent
        @path << [cell.x, cell. y]
        cell = cell.parent
      end
    end

    # return reversed solution path
    @path.reverse!
  end

  def print
    if @path.empty?
      return puts "Solution not found."
    end

    #mark solved path with 'o'
    @path.each do |item|
      @maze[item.first][item.last] = 'o'
    end

    goal = @path.last
    start = @path.first

    # remark start and goal cells
    @maze[goal.first][goal.last] = 'G'
    @maze[start.first][start.last] = 'S'
    
    # remark visited cells as open
    reset_visit_state

    # print solotion path
    puts "\nThe solution is: "
    puts @path.inspect
    puts

    #print 2D maze
    puts @maze
  end

  private
    # remark visited cells as open
    def reset_visit_state
      @maze = @maze.map do |line|
        line.sub('V', '_')
      end
    end

    # adds visitable cells to the queue
    # checks all directions top/bottom/left/right
    # and only adds cells that can be visited from our current cell
    def enqueue_next_cell(cell, queue)
      x = cell.x 
      y = cell.y
      queue << Cell.new(x + 1, y, cell) if can_visit?(x + 1, y)
      queue << Cell.new(x - 1, y, cell) if can_visit?(x - 1, y)
      queue << Cell.new(x, y + 1, cell) if can_visit?(x, y + 1)
      queue << Cell.new(x, y - 1, cell) if can_visit?(x, y - 1)
      queue
    end

    # returns true if cell is marked as G
    def is_exit?(cell)
      @maze[cell.x][cell.y] == 'G'
    end

    # marks cell as visited with a V char
    def mark_visited!(x, y)
      @maze[x][y] = 'V'
    end

    # checks if cell is visitable
    # it must be in bounds
    # it must not have been visited before
    # it must be marked as a pathway with a _ char
    def can_visit?(x, y)
      if !is_inbounds?(x, y) or is_visited?(x, y)
        return false
      end

      is_pathway?(x, y)
    end

    # returns true if cell is visited (V char)
    def is_visited?(x, y)
      @maze[x][y] == 'V'
    end

    # checks if x,y are in bounds of maze array
    def is_inbounds?(x, y)
      true unless y > @maze.max.size-1 or y < 0 or x > @maze.size-1 or x < 0
    end


    # checks if x, y is a valid pathway to be visited next
    def is_pathway?(x, y)
      @maze[x][y] == '_' or is_exit?(Cell.new(x, y, []))
    end
end

# cell struct with x,y and its parent cell
class Cell < Struct.new(:x, :y, :parent)
end
