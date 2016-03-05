module Mazes::Cartesian
# Public: A region of 2-Dimensional Cartesian space.
	class Space < Mazes::Space
# Public: Set up getters for the Space's dimensions.
		attr_reader :dims, :x, :y

# Public: Constructs a Space with 2-Dimensional Cartesian geometry.
#
# x - The Integer size of the X dimension.
# y - The Integer size of the Y dimension.
		def initialize x:, y:
			@x, @y = x, y
			@space = init_space
			init_cells
		end

# Public: Access a Cell at specific coordinates.
#
# x - An Integer coordinate in the X dimension.
# y - An Integer coordinate in the Y dimension.
#
# Returns the Cell at the target coordinates, or nil if one is not present.
		def [] x:, y:
			return nil unless x.between? 0, @y - 1
			return nil unless y.between? 0, @y - 1
			@space[x][y]
		end

# Public: Select a Cell at random from the Space.
#
# Returns a randomly-selected Cell.
		def sample
			x, y = rand(@x), rand(@y)
			self[x: x, y: y]
		end

# Public: Access the Space by successive columns.
#
# Yields an Array of Cells to an implicit block.
		def each_col
			@space.each do |col|
				yield col
			end
		end

# Public: Access the Space by successive rows.
#
# Note: Internally, the Cells are stored by columns, then by rows, so this is
# not as simple as simply iterating across the top level of the @space
# container. Instead, this assembles an array by selecting the same row from all
# columns, then yields the new array.
#
# Yields an Array of Cells to an implicit block.
		def each_row
			@y.times do |row|
				y = []
				@x.times do |col|
					y << self[x: col, y: row]
				end
				yield y
			end
		end

# Public: Access the Space by successive cells.
#
# Yields a Cell to an implicit block.
		def each_cell
			each_col do |col|
				col.each do |cell|
					yield cell if cell
				end
			end
		end

# Internal: Allocate memory to store all the Cells.
		def init_space
			Array.new x do |col|
				Array.new y do |row|
					Cell.new x: col, y: row
				end
			end
		end

# Internal: Inform each Cell of its neighbors in the Space.
		def init_cells
			each_cell do |c|
				col, row = c.x, c.y
				c.up    = self[x: col, y: row - 1]
				c.down  = self[x: col, y: row + 1]
				c.left  = self[x: col - 1, y: row]
				c.right = self[x: col + 1, y: row]
			end
		end

	end
end
