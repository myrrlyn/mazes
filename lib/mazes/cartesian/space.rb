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
		def [] x, y
			return nil unless x.between? 0, @y - 1
			return nil unless y.between? 0, @y - 1
			@space[x][y]
		end

# Public: Select a Cell at random from the Space.
#
# Returns a randomly-selected Cell.
		def sample
			self[rand(@x), rand(@y)]
		end

# Public: Get the size of the Space.
#
# Returns an Integer count of the Cells composing the Space.
		def size
			@x * @y
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
					y << self[col, row]
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
				c.up    = self[col, row - 1]
				c.down  = self[col, row + 1]
				c.left  = self[col - 1, row]
				c.right = self[col + 1, row]
			end
		end

# Public: Represent the Space as text in 2-Dimensional Cartesian geometry.
#
# This is very simple, as paper and computer screens are ALSO 2-D Cartesian.
#
# Returns a String representation of the Space.
		def to_s
			# Instead of doing annoying math to swap the last junction for a corner,
			# just backspace and print a corner.
			ret =  "\u2554#{("\u2550" * 3 + "\u2566") * @x}\b\u2557\n"
			s_width = 4 * (@x + 1)

			each_row do |row|
				mid = "\u2551"
				bot = "\u2560"
				row.each do |cell|
					cell ||= Cell.new x: -1, y: -1
					body = " #{contents_of cell: cell} "
					bound_r = (cell.linked?(cell: cell.right) ? " " : "\u2551")
					bound_d = (cell.linked?(cell: cell.down)  ? " " : "\u2550") * 3
					mid << body << bound_r
					bot << bound_d << "\u256C"
				end
				ret << mid << "\n"
				ret << bot << "\b\u2563\n"
			end
			ret = ret[0, ret.length - s_width]
			ret << "\u255A#{("\u2550" * 3 + "\u2569") * @x}\u0008\u255D\n"

			ret
		end

# Public: Represent the Space as an image in 2-Dimensional Cartesian geometry.
#
# This is very simple, as paper and computer screens are ALSO 2-D Cartesian.
#
# cell_size - An Integer dictating the size of a Cell in pixels.
#   Defaults to 10.
# scalar - A Number that affects the bg_color_for algorithm. See ColorSpace for
#   details.
#
# Returns a PNG representation of the Space.
		def to_png cell_size: 10, scalar: 1.25
			img_w = cell_size * @x
			img_h = cell_size * @y
			img_bg = ChunkyPNG::Color::TRANSPARENT
			img_fg = ChunkyPNG::Color::BLACK
			img = ChunkyPNG::Image.new img_w + 1, img_h + 1, img_bg

			[:bg, :fg].each do |mode|
# Cells are responsible for drawing their right and bottom walls at all times,
# and for drawing their top and left walls only if there are not Cells there to
# draw them instead.
				each_cell do |cell|
					x0, y0 = cell.x * cell_size, cell.y * cell_size
					x1, y1 = (cell.x + 1) * cell_size, (cell.y + 1) * cell_size

					if mode == :bg
						color = bg_color_for cell: cell, scalar: scalar
						img.rect(x0, y0, x1, y1, color, color) if color
					else
						img.line(x0, y0, x1, y0, img_fg) unless cell.up
						img.line(x0, y0, x0, y1, img_fg) unless cell.left
						img.line(x1, y0, x1, y1, img_fg) unless cell.linked? cell: cell.right
						img.line(x0, y1, x1, y1, img_fg) unless cell.linked? cell: cell.down
					end
				end
			end

			img
		end

	end
end
