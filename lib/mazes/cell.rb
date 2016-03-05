module Mazes
# Internal: Standard interface for Cells of any geometry. The Cell is the atomic
# and fundamental unit out of which Spaces and mazes are constructed.
#
# Cell initialization and adjacency are dependent on geometry, and their methods
# here raise NotImplemented exceptions. The logic for inter-Cell linkage is
# independent of geometry, and is included here for common usage. (Note that the
# logic dictating WHICH Cells can and should be linked is wholly up to the
# geometry and algorithm in use, but those only change when the linking methods
# are used, not their actual use.)
	class Cell

# Internal: Constructs a new generic Cell object.
#
# loc - An n-dimensional Array of Integers representing the Cell's location in
#   a parent geometry and Space.
#
# Raises a not-implemented exception.
		def initialize loc:
			@links = Hash.new
			raise "#{self.class} has not implemented a constructor"
		end

# Public: Creates a link between a pair of Cells.
#
# cell - The foreign Cell object to which a Cell is linking.
# bidi - A Boolean determining whether to call this method on the foreign Cell.
#
# When called publicly, this method links the foreign Cell to the subject, and
# then calls itself on the foreign Cell. The bidi parameter is used to prevent
# two Cells from perpetually calling each other to link.
#
# Returns self.
		def link cell:, bidi: true
			@links[cell] = true
			cell.link cell: self, bidi: false if bidi
			self
		end

# Public: Destroys a link between a pair of Cells.
#
# cell - The foreign Cell object from which a Cell is unlinking
# bidi - A Boolean determining whether to call this method on the foreign Cell.
#
# When called publicly, this method unlinks the foreign Cell from the subject,
# and then calls itself on the foreign Cell. The bidi parameter is used to
# prevent two Cells from perpetually calling each other to unlink.
#
# Returns self.
		def unlink cell:, bidi: true
			@links.delete cell
			cell.unlink cell: self, bidi: false if bidi
			self
		end

# Public: Get the list of all Cells to which this Cell is linked.
#
# Returns an Array of linked Cells.
		def links
			@links.keys
		end

# Public: Query if this Cell and a foreign Cell are linked.
#
# cell - The Cell whose link status is being queried.
#
# Returns a Boolean representing link status.
		def linked? cell:
			@links.key? cell
		end

# Internal: Find the Cells directly adjacent to the current Cell.
#
# This method is directly dependent upon local geometry and Space, and must be
# defined in geometry-specific subclasses.
#
# Raises a not-implemented exception.
		def neighbors
			raise "#{self.class} has not implemented adjacency logic"
		end

	end
end
