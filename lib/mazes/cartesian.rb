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

end
