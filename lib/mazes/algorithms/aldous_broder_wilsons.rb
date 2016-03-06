module Mazes::Algorithms
# Public: Uses Aldous-Broder to start (where it is fastest) and then Wilsons to
# finish (where it is fastest).
	class AldousBroderWilsons

# Public: Execute the Aldous-Broder/Wilsons hybrid algorithm.
		def self.act_on space:
			unvisited = []
			space.each_cell do |cell|
				unvisited << cell
			end
			cell = unvisited.sample
			unvisited.delete cell

			while unvisited.length > space.size / 2
				neighbor = cell.neighbors.sample
				if neighbor.links.empty?
					cell.link cell: neighbor
					unvisited.delete neighbor
				end

				cell = neighbor
			end

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
