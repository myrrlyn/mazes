module Mazes::Cartesian
	self.autoload :Cell, "mazes/cartesian/cell"
	self.autoload :Space, "mazes/cartesian/space"
	self.autoload :BinaryTree, "mazes/cartesian/binary_tree"
	self.autoload :Sidewinder, "mazes/cartesian/sidewinder"

# Public: Demonstrate execution of an Algorithm on a Space.
#
# dims - A Hash with Cartesian dimensions => Integer sizes.
# algo - An Algorithm that can act on Cartesian Space.
#
# Prints the Space to a string, and returns it.
	def self.demo_basic dims:, algo:
		s = Space.new x: dims[:x], y: dims[:y]
		algo.act_on space: s
		puts s
		s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
	end

# Public: Demonstrate execution of an Algorithm on a Space, and add a Distance
# map. Same API as above.
	def self.demo_dist dims:, algo:
		s = Space.new x: dims[:x], y: dims[:y]
		algo.act_on space: s
		start = s[x: dims[:x] / 2, y: dims[:y] / 2]
		dists = start.distances
		s.distances = dists
		puts s
		s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
	end

# Public: Execute an Algorithm on a Space and add a single path between two
# Cells. Same API as above.
	def self.demo_trace dims:, algo:
		s = Space.new x: dims[:x], y: dims[:y]
		algo.act_on space: s
		start = s[x: 0, y: dims[:y] - 1]
		dists = start.distances
		s.distances = dists.path_to(goal: s[x: dims[:x] - 1, y: 0])
		puts s
		s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
	end

# Public: Execute an Algorithm on a Space and then look for the longest path in
# the Space and display it. Same API as above.
	def self.demo_max dims:, algo:
		s = Space.new x: dims[:x], y: dims[:y]
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

	def self.demo_color dims:, algo:
		s = Space.new x: dims[:x], y: dims[:y]
		algo.act_on space: s
		start = s[x: dims[:x] / 2, y: dims[:y] / 2]
		s.distances = start.distances
		s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
	end

end
