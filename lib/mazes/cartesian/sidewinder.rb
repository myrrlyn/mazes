module Mazes::Cartesian
# Public: Sidewinder generation algorithm in 2-Dimensional Cartesian space.
	class Sidewinder < Mazes::Algorithm

# Public: Execute the Sidewinder algoirthm on a 2-Dimensional Cartesian Space.
#
# dir_h - A Symbol label for a horizontal adjacency method on Cells.
#   Defaults to :right.
# dir_v - A Symbol label for a vertical adjacency method on Cells.
#   Defaults to :up.
# dir_main - A Symbol dictating whether the Sidewinder should run horizontally
#   or vertically. Options are :h (default), :v.
# rnd - An Integer modifying the random chance of ending a run.
#   Defaults to 2.
#
# The Sidewinder is capable of being given paramters to modify its random spur
# behavior, its primary axis (horizonta or vertical), and the directions in
# which it acts.
#
# Returns the modified Space.
		def self.act_on space:, dir_h: :right, dir_v: :up, dir_main: :h, rnd: 2
			if dir_main == :h
				iter = :each_row
			elsif dir_main == :v
				iter = :each_col
			end
			space.send(iter) do |group|
				run = []
				group.each do |cell|
					run << cell
					at_bound_h = cell.send(dir_h).nil?
					at_bound_v = cell.send(dir_v).nil?
					if dir_main == :h
						should_close = at_bound_h || (!at_bound_v && rand(rnd) == 0)
					elsif dir_main == :v
						should_close = at_bound_v || (!at_bound_h && rand(rnd) == 0)
					end
					if should_close
						mem = run.sample
						if dir_main == :h
							mem.link(cell: mem.send(dir_v)) if mem.send(dir_v)
						elsif dir_main == :v
							mem.link(cell: mem.send(dir_h)) if mem.send(dir_h)
						end
						run.clear
					else
						if dir_main == :h
							cell.link(cell: cell.send(dir_h))
						elsif dir_main == :v
							cell.link(cell: cell.send(dir_v))
						end
					end
				end
			end
			space
		end

	end
end
