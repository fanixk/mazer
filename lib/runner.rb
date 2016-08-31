require_relative 'maze_file_reader'
require_relative 'maze_solver'


file_reader = MazeFileReader.new
maze = file_reader.read('../data/maze.txt')
solver = MazeSolver.new(maze)
solver.solve
# puts arr