module Mazes::Cartesian
	class Mask < Mazes::Mask
		attr_reader :x, :y

# Public: Construct a new Mask with given Cartesian dimensions.
#
# x - An Integer governing size in the X dimension.
# y - An Integer governing size in the Y dimension.
		def initialize x:, y:
			@x, @y = x, y
			@mask = Array.new(@x) do
				Array.new(@y) do
					true
				end
			end
		end

# Public: Access a Cell state at a specific address.
#
# x - An Integer coordinate for the X dimension.
# y - An Integer coordinate for the Y dimension.
#
# Returns a Boolean of the Cell's state.
		def [] x, y
			!!(@mask[x] && @mask[x][y])
		end

# Public: Set a Cell state at a specific address.
#
# x - An Integer coordinate for the X dimension.
# y - An Integer coordinate for the Y dimension.
# b - A Boolean state to be set at the given address.
		def []= x, y, b
			@mask[x][y] = b
		end

# Public: Get a random valid address in the Mask.
#
# Returns an Array [x, y] whose values address a true-set mask entry.
		def sample
			loop do
				x = rand @x
				y = rand @y
				return [x, y] if self[x, y]
			end
		end

# Public: Iterate across the Mask by rows of mask entries.
#
# Yields an Array of Booleans to an implicit block.
		def each_row
			@y.times do |y|
				ret = []
				@x.times do |x|
					ret << self[x, y]
				end
				yield ret
			end
		end

# Public: Iterate across the Mask by columns of mask entries.
#
# Yields an Array of Booleans to an implicit block.
		def each_col
			@mask.each do |x|
				yield x
			end
		end

# Public: Iterate across each mask entry in the Mask.
#
# Yields each successive Boolean mask entry to an implicit block.
		def each_mask
			@mask.each do |x|
				x.each do |m|
					yield m
				end
			end
		end

	end
end
