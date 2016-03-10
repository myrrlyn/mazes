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

# Public: Construct a new Mask using a text file as the reference.
#
# file - A filename String or File reference from which to read.
#
# Returns a new Mask constructed according to the reference file.
		def self.from_txt file:
			if file.is_a? String
				filedata = File.readlines file
			elsif file.is_a? File
				filedata = file.readlines
			end
			filedata.map do |line|
				line.strip!
			end
			filedata.pop while filedata.last.length < 1
			mask = Mask.new x: filedata.first.length, y: filedata.length
			mask.x.times do |col|
				mask.y.times do |row|
					if filedata[row][col] == "X"
						mask[col, row] = false
					else
						mask[col, row] = true
					end
				end
			end
			mask
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
