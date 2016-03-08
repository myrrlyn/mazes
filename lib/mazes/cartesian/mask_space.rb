module Mazes::Cartesian
# Public: Define a Mask-aware Space in 2-D Cartesian geometry.
#
# I *really* need to get a better idea of how Ruby composition works because
# multiple inheritance is not a thing, but this class uses the APIs of both
# Mazes::MaskSpace and Mazes::Cartesian::Space (and both of those use the API of
# Mazes::Space) and it sure would be nice to not have to reimplement either
# superclass' actually-viable general methods.
	class MaskSpace < Mazes::Cartesian::Space
		attr_reader :mask

		def initialize mask:
			@mask = mask
			super x: mask.x, y: mask.y
		end

		def init_space
			Array.new x do |c|
				Array.new y do |r|
					Cell.new(x: c, y: r) if @mask[c, r]
				end
			end
		end

	end
end
