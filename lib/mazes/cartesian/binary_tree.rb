module Mazes::Cartesian
# Public: Binary Tree generation algorithm in 2-Dimensional Cartesian space.
	class BinaryTree < Mazes::Algorithm

# Public: Execute the Binary Tree algorithm on a 2-Dimensional Cartesian Space.
#
# space - A Mazes::Cartesian::Space of Mazes::Cartesian::Cells.
# dir_h - A Symbol label for a horizontal adjacency method on Cells.
#   Defaults to :right
# dir_v - A Symbol label for a vertical adjacency method on Cells.
#   Defaults to :up
#
# Returns the modified Space.
		def self.act_on space:, dir_h: :right, dir_v: :up
			space.each_cell do |cell|
				neighbors = []
				[dir_h, dir_v].each do |dir|
					neighbors << cell.send(dir) if cell.send(dir)
				end
				r = neighbors.sample
				cell.link cell: r if r
			end
			space
		end

	end
end
