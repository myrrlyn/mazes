module Mazes
# Internal: Standard interface for all Space-manipulating Algorithms that create
# mazes. Algorithm subclasses need only define a single method which, when
# called, will execute the algorithm on a Space.
	class Algorithm

# Internal: Executes an algorithm on a Space of Cells.
#
# space - A Space of Cells over which to execute.
#
# The Space is modified in-place, and so the return value need not be captured
# in order to proceed. The space is returned from this function to permit method
# chaining for convenience.
#
# Returns the modified Space.
#
# Raises a NotImplemented exception.
		def self.act_on space:
			raise NotImplemented "#{self.class} has not implemented an action"
			space
		end

	end
end
