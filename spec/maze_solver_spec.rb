require 'spec_helper'
require_relative '../lib/maze_file_reader.rb'
require_relative '../lib/maze_solver.rb'

describe MazeSolver do
  let(:filename) { 'data/maze.txt' }

  subject(:maze_solver) do 
    file_reader = MazeFileReader.new
    maze = file_reader.read('data/maze.txt')
    MazeSolver.new(maze)
  end

  it { is_expected.to respond_to(:solve) }
  it { is_expected.to respond_to(:parse) }
  it { is_expected.to respond_to(:print) }

  it "calls #parse when created" do
    expect_any_instance_of(MazeSolver).to receive(:parse)
    maze_file = MazeFileReader.new.read('data/maze.txt')
    MazeSolver.new(maze_file)
  end

  context "#parse" do
    it "should return an array with the x,y of the starting cell" do
      expect(maze_solver.parse).to eq([5,2])
    end
  end

  context "#solve" do
    it "should return the solution path as an array" do
      expect(maze_solver.solve).to be_an_instance_of(Array)
    end

    it "should return correct path" do
      expect(maze_solver.solve).to eq([[5, 2], [5, 1], [5, 0], [4, 0], [4, 1], [3, 1], [2, 1], [2, 2], [2, 3], [2, 4], [2, 5], [2, 6], [1, 6], [0, 6], [0, 5], [0, 4]])
    end
  end
end
