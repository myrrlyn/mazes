module Mazes::Algorithms
# Public: Recursive Backtracker generation algorithm. Depth-first search using a
# stack to record history and state.
	class RecursiveBacktracker < Mazes::Algorithm

# Public: Execute the Recursive Backtracker algorithm.
		def self.act_on space:, origin: space.sample
			stack = []
			stack.push origin

			while stack.any?
				current = stack.last
				neighbors = current.neighbors.select do |n|
					n.links.empty?
				end

				if neighbors.empty?
					stack.pop
				else
					neighbor = neighbors.sample
					current.link cell: neighbor
					stack.push neighbor
				end
			end

			space
		end

	end
end
