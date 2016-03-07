module Mazes::Algorithms
# Public: Wilsons generation algorithm. This algorithm works slowly on startup
# but accelerates as it proceeds. It performs a loop-erased random walk that
# starts in the wilderness (unvisited space) and seeks visited Cells. With a
# large unvisited and small visited population, the first several walks can take
# a long time to end, but as the visited population grows, walks are faster and
# shorter.
	class Wilsons < Mazes::Algorithm
		require "pry"

# Public: Executes the Wilsons algorithm on a Space.
		def self.act_on space:, origin: space.sample
# Shunt each Cell into a flat list for tracking.
			unvisited = []
			space.each_cell do |cell|
				unvisited << cell
			end

# Mark the starting Cell as visited to serve as a target for walking.
			unvisited.delete origin

			while unvisited.any?
				cell = unvisited.sample
				path = [cell]
				while unvisited.include? cell
					cell = cell.neighbors.sample
					position = path.index cell
# This erases any loops that form by truncating the path to the first time the
# junction Cell is explored.
					if position
						path = path[0..position]
					else
						path << cell
					end
				end

# Once a path from a random point to a visited Cell is established, it is linked
# into the maze and its Cells marked as visited.
				0.upto(path.length - 2) do |index|
					path[index].link cell: path[index + 1]
					unvisited.delete path[index]
				end
			end

			space
		end

	end
end
