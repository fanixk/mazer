class MazeFileReader

  attr_reader :maze

  def initialize
    @maze = []
  end

  def read(filename)
    @maze = File.open(filename, 'r').readlines
    @maze.each(&:strip!)
    validate
    @maze
  end

  private
    def validate
      line_sizes = @maze.map { |line| line.size }
      
      raise 'Wrong line size.' unless line_sizes.uniq.count == 1

      start_length = @maze.select { |l| l.include? 'S' }.count
      goal_length = @maze.select { |l| l.include? 'G' }.count
      
      raise 'Only one Start/Goal square allowed.' unless (start_length == 1 and goal_length == 1)
    end
end