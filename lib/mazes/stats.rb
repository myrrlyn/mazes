require "benchmark"

module Mazes
	class Stats

		def self.run
			algos = [
				Algorithms::AldousBroder,
				Algorithms::AldousBroderWilsons,
				Algorithms::HunterKiller,
				Algorithms::Wilsons,
				Cartesian::BinaryTree,
				Cartesian::Sidewinder,
			]

			tries = 200
			size_x = 50
			size_y = 50

			averages = {}
			algos.each do |algo|
				puts "Running #{algo.to_s.gsub(/.*::/,'')}"
				deadend_counts = []
				time = Benchmark.measure do
					tries.times do
						s = Cartesian::Space.new x: size_x, y: size_y
						algo.act_on space: s
						deadend_counts << s.deadends.count
					end
				end
				puts "#{algo.name.ljust(20)} | #{time}"

				total_deadends = deadend_counts.inject(0) do |s, a|
					s + a
				end
				averages[algo] = total_deadends / deadend_counts.length
			end
			total_cells = size_x * size_y
			puts
			puts "Average dead-ends per #{size_x}x#{size_y} (#{total_cells}) maze:"
			puts
			sorted_algos = algos.sort_by do |algo|
				-averages[algo]
			end
			sorted_algos.each do |algo|
				percentage = averages[algo] * 100.0 / total_cells
				puts "%20s : %3d/%d (%d%%)" % [
					algo.name,
					averages[algo],
					total_cells,
					percentage
				]
			end
		end
	end
end
