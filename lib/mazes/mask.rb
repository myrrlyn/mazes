module Mazes
# Internal: Standard interface for Cell masking in a Space. As Masks map
# directly to Spaces, they must necessarily be defined by each geometry.
	class Mask

# Internal: Constructs a new generic Mask to define Cell status.
#
# dims - An n-dimensional Array of Integers representing the size of the
#   enclosed geometry.
#
# Raises a not-implemented exception.
		def initialize dims:
			@dims = dims
			@mask = []
			raise "#{self.class} has not implemented a constructor"
		end

# Internal: Constructs a new generic Mask using a text-file input.
#
# file - A filename or File containing plaintext.
#
# Raises a not-implemented exception.
		def from_txt file:
			@mask = []
			raise "#{self.class} has not implemented a text-file constructor"
		end

# Internal: Constructs a new generic Mask using an image-file input.
#
# file - A filename or File containing an image.
#
# Raises a not-implemented exception.
		def from_img file:
			@mask = []
			raise "#{self.class} has not implemented an image-file constructor"
		end

# Internal: Access a specific Cell's mask.
#
# dim - An n-dimensional Integer Array of coordinates at which to retreive a
#   Cell mask.
#
# Raises a not-implemented exception.
		def [] dim
			valid = true
			dim.each_index do |i|
				valid &&= dim[i].between? 0, @dims[i]
			end
			valid && !!@mask[dim]
			raise "#{self.class} has not implemented a lookup reader"
		end

# Internal: Set a specific Cell's mask.
#
# dim - An n-dimensional Integer Array of coordinates at which to set a Cell
#   mask.
# state - A Boolean value to which the Cell's mask will be set.
#
# Raises a not-implemented exception.
		def []= dim, state
			valid = true
			dim.each_index do |i|
				valid &&= dim[i].between? 0, @dims[i]
			end
			@mask[dim] = state if valid
			@mask[dim] = false if !valid
			raise "#{self.class} has not implemented a lookup writer"
		end

# Public: Get a count of all masks set to true.
#
# Returns an Integer count of all true masks.
		def size
			count = 0
			each_mask do |c|
				count += 1 if c
			end
			count
		end

# Internal: Select a mask at random from the collection.
#
# Returns a dims array of a randomly chosen true-mask.
# Raises a not-implemented exception.
		def sample
			ret = []
			@dims.each do |d|
				ret << rand(d)
			end
			raise "#{self.class} has not implemented a random sampler"
			ret
		end

# Internal: Iterate across all masks in the collection.
#
# Raises a not-implemented exception.
		def each_mask
			raise "#{self.class} has not implemented a mask iterator"
		end

	end
end
