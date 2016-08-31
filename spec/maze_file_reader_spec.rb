require 'rspec'
require_relative '../lib/maze_file_reader.rb'

describe MazeFileReader do
  let(:filename) { '../data/maze.txt' }
  subject(:file_reader) { MazeFileReader.new }

  it { is_expected.to respond_to(:maze) }
  it { is_expected.to respond_to(:read) }

  context "#read" do
    subject(:maze) { MazeFileReader.new.read(filename) }
    subject(:joined_maze) { maze.join }

    it "creates an array of the correct size" do
      expect(joined_maze.size).to eq (maze.size * maze.first.size)
    end

    it { expect(maze).not_to be_empty }

    it { expect(joined_maze).to include("S", "G", "_", "X") }
  end

  context "validation" do
    subject(:maze_size) { MazeFileReader.new.read('../data/maze_size_error.txt') }
    subject(:maze_sg) { MazeFileReader.new.read('../data/maze_sg_error.txt') }

    it "raises error when file lines are not same length" do
      expect { maze_size }.to raise_error(RuntimeError, 'Wrong line size.')
    end

    it "raises error when there are more than one S/G squares" do
      expect { maze_sg }.to raise_error(RuntimeError, 'Only one Start/Goal square allowed.')
    end
  end
end
