module Mazes
# Public: Standard interface for mapping distances along Cells in a Space.
	class Distances

# Public: Construct a new Distances listing from a given root cell.
#
# root - A Cell to use as the base reference for distance measurements.
		def initialize root:
			@root = root
			@cells = Hash.new
			@cells[@root] = 0
		end

# Public: Access the distance for a Cell from the list.
#
# cell - A Cell to query for distance.
#
# Returns an integer distance to the target Cell.
		def [] cell
			@cells[cell]
		end

# Public: Enter a Cell into the Distances list.
#
# cell - A Cell to be recorded.
# dist - The distance from the root Cell to the current Cell.
		def []= cell, dist
			@cells[cell] = dist
		end

# Public: Retrieve all the Cells entered into the Distances list.
#
# Returns an Array of Cells.
		def cells
			@cells.keys
		end

# Public: Find the shortest path from a root cell to a goal.
#
# goal - The Cell to which the path is being sought.
#
# Returns a Distances instance with only a single path (root -> goal) solved.
		def path_to goal:
			current = goal
			trail = Distances.new root: @root
			trail[current] = @cells[current]

			until current == @root
				current.links.each do |neighbor|
					if @cells[neighbor] < @cells[current]
						trail[neighbor] = @cells[neighbor]
						current = neighbor
						break
					end
				end
			end

			trail
		end

# Public: Find the farthest Cell from the root Cell in a given Space.
#
# Returns a tuple (Array) containing the farthest Cell and its Integer distance.
		def farthest
			max_cell, max_dist = @root, 0

			@cells.each do |cell, dist|
				if dist > max_dist
					max_cell, max_dist = cell, dist
				end
			end

			[max_cell, max_dist]
		end

# Public: Find the longest single path between any two Cells in a Space.
#
# Returns a Distances instance with only the longest path solved.
		def max_path
			max_cell, max_dist = farthest
			new_dists = max_cell.distances
			max_cell, max_dist = new_dists.farthest
			new_dists.path_to goal: max_cell
		end

	end
end
