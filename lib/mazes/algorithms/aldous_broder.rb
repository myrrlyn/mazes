module Mazes::Algorithms
# Public: Aldous-Broder generation algorithm. This algorithm works rapidly on
# startup but slows down as it proceeds. It performs random walks from visited
# Cells into the wilderness (unvisited space), only ending a walk when it again
# returns to visited space. As visited space grows and unvisited space shrinks,
# random walks take longer and longer to reach the remaining unvisited cells,
# resutling in its characteristic deceleration.
	class AldousBroder < Mazes::Algorithm

# Public: Executes the Aldous-Broder algorithm on a Space.
		def self.act_on space:, origin: space.sample
			unvisited = []
			space.each_cell do |cell|
				unvisited << cell
			end
			cell = origin
			unvisited.delete cell

			while unvisited.size > 0
				neighbor = cell.neighbors.sample
				if neighbor.links.empty?
					cell.link cell: neighbor
					unvisited.delete neighbor
				end

				cell = neighbor
			end

			space
		end

	end
end
