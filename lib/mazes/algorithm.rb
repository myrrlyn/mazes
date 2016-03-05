module Mazes
# Internal: Standard interface for all Space-manipulating Algorithms that create
# mazes. Algorithm subclasses need only define a single method which, when
# called, will execute the algorithm on a Space.
	class Algorithm

# Internal: Executes an algorithm on a Space of Cells.
#
# space - A Space of Cells over which to execute.
#
# As the Space is modified in-place, this needs not return anything.
#
# Raises a NotImplemented exception.
		def act_on space:
			raise NotImplemented "#{self.class} has not implemented an action"
		end

	end
end
