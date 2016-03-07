require "benchmark"

module Mazes
	class Stats

		def self.run tries: 200, size: [50, 50]
			algos = [
				Cartesian::BinaryTree,
				Cartesian::Sidewinder,
				Algorithms::AldousBroder,
				Algorithms::Wilsons,
				Algorithms::AldousBroderWilsons,
				Algorithms::HunterKiller,
				Algorithms::RecursiveBacktracker,
			]

			averages = {}
			algos.each do |algo|
				puts "Running #{algo}"
				deadend_counts = []
				time = Benchmark.measure do
					tries.times do
						s = Cartesian::Space.new x: size[0], y: size[1]
						algo.act_on space: s
						deadend_counts << s.deadends.count
					end
				end
				puts "#{algo.to_s.ljust(20)} | #{time}"

				total_deadends = deadend_counts.inject(0) do |s, a|
					s + a
				end
				averages[algo] = total_deadends / deadend_counts.length
			end
			total_cells = size[0] * size[1]
			puts
			puts "Average dead-ends per #{size[0]}x#{size[1]} (#{total_cells}) maze:"
			puts
			sorted_algos = algos.sort_by do |algo|
				-averages[algo]
			end
			sorted_algos.each do |algo|
				percentage = averages[algo] * 100.0 / total_cells
				puts "%20s : %3d/%d (%d%%)" % [
					algo,
					averages[algo],
					total_cells,
					percentage
				]
			end
		end
	end
end
