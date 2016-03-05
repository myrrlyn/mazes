module Mazes
# Internal: Standard interface for an arrangement of Cells in geometrical space.
# The Space is the object which gives Cells local context and on which
# Algorithms are executed.
	class Space

# Internal: Constructs a new generic Space to contain Cells.
#
# dims - An n-dimensional Array of Integers representing the size of the
#   encolosed geometry.
#
# Raises a not-implemented exception.
		def initialize dims:
			@dims = dims
			@space = init_space
			init_cell
			raise "#{self.class} has not implemented a constructor"
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
		def init_cell
			raise "#{self.class} has not implemented a cell initializer"
		end

	end
end
