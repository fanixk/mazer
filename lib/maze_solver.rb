
class MazeSolver

  def initialize(maze)
    @maze = maze
    # @print = maze.map { |l| l.split(//) }
    @print = maze
    @start = self.parse
  end

  # find S
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
    queue << Cell.new(@start.first, @start.last, cell)

    while !queue.empty? and !exit
      cell = queue.pop

      x = cell.x
      y = cell.y

      if is_exit?(cell)
        exit = true
      else
        mark_visited!(x, y)
        queue = enqueue_next_cell(cell, queue)  
      end
    end

    if exit
      path = []
      while cell.parent
        path << [cell.x, cell. y]
        cell = cell.parent
      end

      print(path)
    else
      puts "Solution not found."
    end
  end

  private
    def reset_visit_state
    end

    def print(path)
      path.each do |item|
        @maze[item.first][item.last] = 'o'
      end
      @maze[path.first.first][path.first.last] = 'G'
      @maze[path.last.first][path.last.last] = 'S'

      puts "\nThe solution is: "
      puts path.reverse.inspect
      puts
      puts @maze
    end

    def enqueue_next_cell(cell, queue)
      x = cell.x 
      y = cell.y
      queue << Cell.new(x + 1, y, cell) if can_visit?(x + 1, y)
      queue << Cell.new(x - 1, y, cell) if can_visit?(x - 1, y)

      queue << Cell.new(x, y + 1, cell) if can_visit?(x, y + 1)
      queue << Cell.new(x, y - 1, cell) if can_visit?(x, y - 1)    
      queue
    end

    def is_exit?(cell)
      @maze[cell.x][cell.y] == 'G'
    end

    def mark_visited!(x, y)
      @maze[x][y] = 'V'
    end

    def mark_unvisited!(x, y)
      @maze[x][y] = '_'
    end

    def can_visit?(x, y)
      if !is_inbounds?(x, y) or is_visited?(x, y)
        return false
      end

      is_pathway?(x, y)
    end

    def is_visited?(x, y)
      @maze[x][y] == 'V'
    end

    def is_inbounds?(x, y)
      true unless y > @maze.max.size-1 or y < 0 or x > @maze.size-1 or x < 0
    end

    def is_pathway?(x, y)
      @maze[x][y] == '_' or is_exit?(Cell.new(x, y, []))
    end
end

class Cell < Struct.new(:x, :y, :parent)
end
