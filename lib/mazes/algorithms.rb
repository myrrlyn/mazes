# Container module for Algorithms that work in any type of geometry. These
# Algorithms use Cell and/or Space APIs that are implemented in specific
# subclasses to operate, and thus are not constrained to individual geometries.
module Mazes::Algorithms
	self.autoload :AldousBroder, "mazes/algorithms/aldous_broder"
	self.autoload :Wilsons, "mazes/algorithms/wilsons"

	# Public: Demonstrate execution of an Algorithm on a Space.
	#
	# dims - An Array with appropriate Integer dimensions.
	# algo - An Algorithm that can act on any Space.
	# space - A Space subclass with specific geometry.
	#
	# Prints the Space to a string, and returns it.
		def self.demo_basic dims:, algo:, space: Mazes::Cartesian::Space
			s = space.new x: dims[0], y: dims[1]
			algo.act_on space: s
			puts s
			s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
		end

	# Public: Demonstrate execution of an Algorithm on a Space, and add a Distance
	# map. Same API as above.
		def self.demo_dist dims:, algo:, space: Mazes::Cartesian::Space
			s = space.new x: dims[0], y: dims[1]
			algo.act_on space: s
			start = s[x: dims[0] / 2, y: dims[1] / 2]
			dists = start.distances
			s.distances = dists
			puts s
			s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
		end

	# Public: Execute an Algorithm on a Space and add a single path between two
	# Cells. Same API as above.
		def self.demo_trace dims:, algo:, space: Mazes::Cartesian::Space
			s = space.new x: dims[0], y: dims[1]
			algo.act_on space: s
			start = s[x: 0, y: dims[1] - 1]
			dists = start.distances
			s.distances = dists.path_to(goal: s[x: dims[0] - 1, y: 0])
			puts s
			s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
		end

	# Public: Execute an Algorithm on a Space and then look for the longest path in
	# the Space and display it. Same API as above.
		def self.demo_max dims:, algo:, space: Mazes::Cartesian::Space
			s = space.new x: dims[0], y: dims[1]
			algo.act_on space: s
			start = s[x:0, y:0]
			dists = start.distances
			new_start, distance = dists.max_path
			new_dists = new_start.distances
			goal, distance = new_dists.max_path
			s.distances = new_dists.path_to goal: goal
			puts s
			s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
		end

		def self.demo_color dims:, algo:, space: Mazes::Cartesian::Space
			s = space.new x: dims[0], y: dims[1]
			algo.act_on space: s
			start = s[x: dims[0] / 2, y: dims[1] / 2]
			s.distances = start.distances
			s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
		end
end
