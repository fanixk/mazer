require_relative 'maze'
require_relative 'maze_solver'


maze = Maze.new
arr = maze.read_from_file('../data/maze.txt')
solver = MazeSolver.new(arr)
solver.parse_maze
# puts arr