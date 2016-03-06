module Mazes::Algorithms
# Public: Wilsons generation algorithm. This algorithm works slowly on startup
# but accelerates as it proceeds.
	class Wilsons < Mazes::Algorithm
		require "pry"

# Public: Executes the Wilsons algorithm on a Space.
		def self.act_on space:
			@n = 0
			unvisited = []
			space.each_cell do |cell|
				unvisited << cell
			end

			first = unvisited.sample
			unvisited.delete first

			while unvisited.any?
				cell = unvisited.sample
				path = [cell]
				while unvisited.include? cell
					cell = cell.neighbors.sample
					position = path.index cell
					if position
						path = path[0..position]
					else
						path << cell
					end
				end

				0.upto(path.length - 2) do |index|
					path[index].link cell: path[index + 1]
					unvisited.delete path[index]
				end
			end

			space
		end

	end
end
