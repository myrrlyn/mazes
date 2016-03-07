module Mazes::Algorithms
# Public: Hunter-Killer generator algorthm. Breadth-first search starting from a
# random position and growing outwards until collision, then selecting an
# untouched Cell on the frontier and running again.
	class HunterKiller < Mazes::Algorithm

# Public: Execute the Hunter-Killer algorithm.
		def self.act_on space:, origin: space.sample
			current = origin

			while current
				unvisited_neighbors = current.neighbors.select do |n|
					n.links.empty?
				end

				if unvisited_neighbors.any?
					neighbor = unvisited_neighbors.sample
					current.link cell: neighbor
					current = neighbor
				else
					current = nil
					space.each_cell do |c|
						visited_neighbors = c.neighbors.select do |n|
							n.links.any?
						end
						if c.links.empty? and visited_neighbors.any?
							current = c
							current.link cell: visited_neighbors.sample
							break
						end
					end
				end
			end

			space
		end

	end
end
