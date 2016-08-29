class MazeSolver

  def initialize(maze)
    @maze = maze
  end

  # find S
  def parse_maze
    start_x = 0
    start_y = 0

    # line = @maze.select.with_index { |line, index| index if line.include? 'S'}
    # start_y = @maze.each_index.select { |i| @maze[i].include? 'S' }.first
    # start_x = @maze[start_y].index('S')

    @maze.each_with_index do |line, index|
      if line.include? 'S'
        start_x = line.index('S')
        start_y = index
        break
      end
    end
    puts "Start x = #{start_x}"
    puts "Start y = #{start_y}"
  end

  def solve
  end

end