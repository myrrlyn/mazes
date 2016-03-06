module Mazes::Algorithms
# Public: Aldous-Broder generation algorithm. This algorithm works rapidly on
# startup but slows down as it proceeds.
	class AldousBroder < Mazes::Algorithm

# Public: Executes the Aldous-Broder algorithm on a Space.
		def self.act_on space:
			cell = space.sample
			unvisited = space.size - 1

			while unvisited > 0
				neighbor = cell.neighbors.sample
				if neighbor.links.empty?
					cell.link cell: neighbor
					unvisited -= 1
				end

				cell = neighbor
			end

			space
		end

	end
end
