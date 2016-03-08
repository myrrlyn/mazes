module Mazes
# Internal: Standard interface for a Space defined using a Mask, rather than
# explicit dimensional information. Note that the Mask must be of the same
# geometry as the Space. Currently this is unchecked. Behave.
	class MaskSpace < Space
		attr_reader :mask

# Internal: Construct a new Space using a Mask for definition.
#
# mask - A Mask of matching geometry.
#
# Raises a not-implemented exception in the super call.
		def initialize mask:
			@mask = mask
			super dims: mask.dims
		end

# Internal: Override the space initializer to only create Cells if the Mask
# permits it, leaving forbidden areas nil.
#
# Raises a not-implemented exception.
		def init_space
			raise "#{self.class} has not implemented a Space initializer"
		end

# Public: Randomly select a Cell.
#
# This works by asking the Mask for a valid random location, and then returns
# the Cell at that address.
#
# This will need to be re-implemented by any geometry subclasses that use kwargs
# since I don't know if it's possible to translate a Hash into kwargs. Posargs
# should work fine; the * unpacks the returned Array.
#
# Returns a Cell, randomly chosen.
		def sample
			self[*@mask.sample]
		end

# Public: Get the count of all the valid Cells in the Space.
#
# Since the Space is built using the Mask, just ask the Mask how many valid
# Cells exist.
#
# Returns an Integer count of all the valid Cells in the Space.
		def size
			@mask.size
		end

	end
end
