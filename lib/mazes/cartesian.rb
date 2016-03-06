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
		algo.act_on space: s, dir_v: :down, dir_h: :left
		puts s
		s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
	end

# Public: Demonstrate execution of an Algorithm on a Space, and add a Distance
# map. Same API as above.
	def self.demo_dist dims:, algo:
		s = Space.new x: dims[:x], y: dims[:y]
		algo.act_on space: s, dir_v: :up, dir_h: :left
		start = s[x: dims[:x] / 2, y: dims[:y] / 2]
		dists = start.distances
		s.distances = dists
		puts s
		s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
	end

	def self.demo_trace dims:, algo:
		s = Space.new x: dims[:x], y: dims[:y]
		algo.act_on space: s, dir_v: :down, dir_h: :right
		start = s[x: 0, y: dims[:y] - 1]
		dists = start.distances
		s.distances = dists.path_to(goal: s[x: dims[:x] - 1, y: 0])
		puts s
		s.to_png.save "build/#{algo.to_s.gsub(/.*::/, '').downcase}.png"
	end

end
