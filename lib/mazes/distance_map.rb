# Public: Module for adding a Distances map to a Space. This is designed for
# composition, so simply including this module into any Space will give it the
# ability to overlay a Distance map onto the Space's render.
module Mazes::DistanceMap
	attr_accessor :distances

# Public: Print a Cell's distance value when asked.
#
# cell - A Cell whose contents are being queried.
#
# Returns a single-character String.
#
# Calls the previous contents_of method if a distances value cannot be achieved.
# Internal: Get the contents of a Cell. Cells can dictate their own contents, or
# default to using a blank space.
	def contents_of cell:
		if distances && distances[cell]
			distances[cell].to_s(36)[-1]
		else
			" "
		end
	end

end
