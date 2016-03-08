module Mazes
	# Global information
	self.autoload :VERSION, "mazes/version"
	# Base interface classes
	self.autoload :Algorithm, "mazes/algorithm"
	self.autoload :Cell, "mazes/cell"
	self.autoload :Space, "mazes/space"
	self.autoload :Mask, "mazes/mask"
	self.autoload :MaskSpace, "mazes/mask_space"
	# Extensions
	self.autoload :Distances, "mazes/distances"
	self.autoload :ColorSpace, "mazes/color_space"
	self.autoload :DistanceMap, "mazes/distance_map"
	self.autoload :Algorithms, "mazes/algorithms"
	self.autoload :Cartesian, "mazes/cartesian"
	# Extra features
	self.autoload :Stats, "mazes/stats"
end
