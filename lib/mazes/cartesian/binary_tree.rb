module Mazes::Cartesian
# Public: Binary Tree generation algorithm in 2-Dimensional Cartesian space.
# This is an iterative, not random, algorithm, and has unpleasant biases and has
# a completely empty edge in each direction. It is cheap as hell, but should not
# be used for anything but rapid prototyping of a basic maze, and is certainly
# not suitable for production use.
	class BinaryTree < Mazes::Algorithm

# Public: Execute the Binary Tree algorithm on a 2-Dimensional Cartesian Space.
#
# dir_h - A Symbol label for a horizontal adjacency method on Cells.
#   Defaults to :right.
# dir_v - A Symbol label for a vertical adjacency method on Cells.
#   Defaults to :up.
#
# The directional parameters dictate the sides on which the two fully empty runs
# are placed.
#
# Returns the modified Space.
		def self.act_on space:, origin: space.sample, dir_h: :right, dir_v: :up
			space.each_cell do |cell|
				neighbors = []
				[dir_h, dir_v].each do |dir|
					neighbors << cell.send(dir) if cell.send(dir)
				end
				r = neighbors.sample
				cell.link cell: r if r
			end
			space
		end

	end
end
