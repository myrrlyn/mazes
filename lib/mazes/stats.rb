require "benchmark"

module Mazes
	class Stats

		def self.run tries: 100, size: [50, 50]
			algos = [
				Cartesian::BinaryTree,
				Cartesian::Sidewinder,
				Algorithms::AldousBroder,
				Algorithms::Wilsons,
				Algorithms::AldousBroderWilsons,
				Algorithms::HunterKiller,
				Algorithms::RecursiveBacktracker,
			]

			averages  = {}
			distances = {}
			algos.each do |algo|
				deadend_counts  = []
				distance_counts = []
				time = Benchmark.measure do
					tries.times do
						s = Cartesian::Space.new x: size[0], y: size[1]
						algo.act_on space: s
						deadend_counts  << s.deadends.count
						distance_counts << s[x: 0, y: 0].distances.max_path.farthest[1]
					end
				end
				puts "#{algo.to_s.ljust(20)} | #{time}"

				total_deadends  =  deadend_counts.inject(0) do |s, a|
					s + a
				end
				total_distances = distance_counts.inject(0) do |s, a|
					s + a
				end
				averages[algo]  = total_deadends  /  deadend_counts.length
				distances[algo] = total_distances / distance_counts.length
			end
			total_cells = size[0] * size[1]
			puts
			puts "Average statistics per #{size[0]}x#{size[1]} (#{total_cells}) maze:"
			puts
			puts "%20s | %15s | %s" % ["Algorithm", "Dead Ends", "Max Path Length"]
			algos.each do |algo|
				percentage = averages[algo] * 100.0 / total_cells
				puts "%20s | %4d/%d (%2d%%) | %d" % [
					algo,
					averages[algo],
					total_cells,
					percentage,
					distances[algo],
				]
			end
		end
	end
end
