module Mazes::Cartesian
# Public: A Cell in 2-Dimensional Cartesian space.
	class Cell < Mazes::Cell

# Public: Set up getters for the Cell's location in its parent Space.
		attr_reader :x, :y

# Public: Set up accessors for the Cell's neighbors in its parent Space.
		attr_accessor :up, :down, :left, :right

# Public: Construct the Cell with its location in 2-Dimensional Cartesian space.
#
# x - The Integer value of the Cell's position in the X dimension
# y - The Integer value of the Cell's position in the Y dimension
		def initialize x:, y:
			@x, @y = x, y
			@links = Hash.new
		end

		def neighbors
			ret = []
			[up, down, left, right].each do |n|
				ret << n if n
			end
			ret
		end

	end
end
