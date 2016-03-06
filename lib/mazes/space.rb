require "chunky_png"

module Mazes
# Internal: Standard interface for an arrangement of Cells in geometrical space.
# The Space is the object which gives Cells local context and on which
# Algorithms are executed.
	class Space
		include DistanceMap
		include ColorSpace

# Internal: Constructs a new generic Space to contain Cells.
#
# dims - An n-dimensional Array of Integers representing the size of the
#   encolosed geometry.
#
# Raises a not-implemented exception.
		def initialize dims:
			@dims = dims
			@space = init_space
			init_cells
			raise "#{self.class} has not implemented a constructor"
		end

# Internal: Access a Cell from inside the Space.
#
# dim - An n-dimensional Integer Array of coordinates at which to retreive a
#   Cell.
#
# Raises a not-implemented exception.
		def [] dim
		end

# Internal: Get a Cell at random.
#
# Raises a not-implemented exception.
		def sample
			raise "#{self.class} has not implemented a random sampler"
		end

# Internal: Iterate across all the Cells in a Space
		def each_cell
			raise "#{self.class} has not implemented a cell iterator"
		end

# Internal: Allocates memory to fit the Space's dimensions.
#
# Raises a not-implemented exception.
		def init_space
			raise "#{self.class} has not implemented a space initializer"
		end

# Internal: Initializes the Cells according to local geometric rules.
#
# Raises a not-implemented exception.
		def init_cells
			raise "#{self.class} has not implemented a cell initializer"
		end

# Internal: Represent the Space as text according to local geometric rules.
#
# Returns a String representation of the Space.
# Raises a not-implemented exception.
		def to_s
			raise "#{self.class} has not implemented a text representation"
		end

# Internal: Represent the Space as an image according to local geometric rules.
#
# Return a PNG representation of the Space.
# Raises a not-implemented exception.
		def to_png
			raise "#{self.class} has not implemented an image representation"
		end

	end
end
