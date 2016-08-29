require 'rspec'
require_relative '../lib/maze.rb'

describe Maze do
  let(:filename) { '../data/maze.txt' }
  subject(:maze) { Maze.new }

  it { is_expected.to respond_to(:maze) }
  it { is_expected.to respond_to(:read_from_file) }

  context "read_from_file" do
    subject(:maze) { Maze.new.read_from_file(filename) }
    subject(:joined_maze) { maze.join }

    it "creates an array of the correct size" do
      expect(joined_maze).to eq (maze.size * maze.first.size)
    end

    it { expect(maze).not_to be_empty }

    it { expect(joined_maze).to include("S", "G", "_", "X") }

    #TODO check validation
  end
end
