module Mazes
# Internal: Standard interface for all Space-manipulating Algorithms that create
# mazes. Algorithm subclasses need only define a single method which, when
# called, will execute the algorithm on a Space.
	class Algorithm

# Internal: Executes an algorithm on a Space of Cells.
#
# space - A Space of Cells over which to execute.
# origin - A Cell from which to start the Algorithm. Defaults to random choice.
#   Iterative Algorithms do not use origin; random Algorithms do. However, all
#   Algorithm subclasses must include it in their signature, even if it is going
#   to be discarded, in order to fit Ruby's expectations.
#
# The Space is modified in-place, and so the return value need not be captured
# in order to proceed. The space is returned from this function to permit method
# chaining for convenience.
#
# Returns the modified Space.
#
# Raises a NotImplemented exception.
		def self.act_on space:, origin: space.sample
			raise NotImplemented "#{self.class} has not implemented an action"
			space
		end

# Public: Strip the scoping identifiers from the Algorithm name, because frankly
# Mazes::Algorithms:: is just a waste of space.
#
# TODO: Figure out how to shadow to_s but still be able to use it.
#
# Returns a String naming the Algorithm.
		def self.name
			self.to_s.gsub(/.*::/, '')
		end

	end
end
