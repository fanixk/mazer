class Maze

  attr_reader :maze

  def initialize
    @maze = []
  end

  def read_from_file(filename)
    @maze = File.open(filename, 'r').readlines
    @maze.each(&:strip!)
    validate
    @maze

  end

  private
    def validate
      line_sizes = @maze.map { |line| line.size }
      raise 'Wrong line size!' unless line_sizes.uniq.count == 1

      #TODO check only one S and one G
    end


end