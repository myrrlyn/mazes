require "benchmark"
require "descriptive_statistics"

module Mazes
	class Stats

# Public: Do timing, dead-end, and path-length analysis on the Algorithms.
#
# tries - Integer count of trials per Algorithm
# size  - Integer Array of Space dimensions
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

# Public: Collect data for a series of dimensions and emit it to a file suitable
# for further processing. Currently, this emits in column-labeled CSV.
#
# trials - Integer count of trials per Algorithm.
# max_size - Integer maximum of Space dimensions.
# verbose - A Boolean controlling status updates to stdout.
#
# NOTE: This is a COMPREHENSIVE data gathering routine. It will run the given
# number of trials for all possible Space sizes inside the max_size parameter.
# Currently, only Cartesian space is implemented, and so to reduce duplication
# of effort equivalent Spaces will not be generated (i.e. it assumes [5, 4] has
# the same characteristics as [4, 5]). This means that at default values of 100
# trials and max size, 100 iterations of [1,1], [2, 1], [2, 2], ... [100, 99],
# [100, 100] will be performed for EACH ALGORITHM. THIS WILL TAKE A VERY LONG
# TIME AND CONSUME A LOT OF POWER.
#
# DO NOT DO THIS FOR LARGE VALUES OF TRIALS OR MAX_SIZE EXCEPT ON A MACHINE THAT
# HAS THE RESOURCES TO DO IT. THIS IS DEFINITELY AN OVERNIGHT OR WEEKEND TASK.
#
# TODO: Allow clients to control the gathered Algorithms, measurements, and
# statistics. This should probably be done on a combinational basis, e.g.,
# disabling stat.min mutes .min statistics for all measurements, disabling real
# ignores the realtime measurement, disabling a specific Algorithm removes it
# from the main loop.
#
# TODO: Allow the possibility of recording each generated maze to a text and/or
# image rendering, because why not.
#
# Writes results to files, build/#{algorithm}.csv
# Returns nil
		def self.report trials: 100, max_size: 100, verbose: true
			algos = [
				Cartesian::BinaryTree,
				Cartesian::Sidewinder,
				Algorithms::AldousBroder,
				Algorithms::Wilsons,
				Algorithms::AldousBroderWilsons,
				Algorithms::HunterKiller,
				Algorithms::RecursiveBacktracker,
			]
			jm = max_size.to_s.length
			algos.each do |a|
				File.open "build/#{a}.csv", "w", 0644 do |f|
					f << "x,y,"
					f << "utime.mean,utime.stddev,utime.min,utime.max,"
					f << "cutime.mean,cutime.stddev,cutime.min,cutime.max,"
					f << "stime.mean,stime.stddev,stime.min,stime.max,"
					f << "cstime.mean,cstime.stddev,cstime.min,cstime.max,"
					f << "real.mean,real.stddev,real.min,real.max,"
					f << "total.mean,total.stddev,total.min,total.max,"
					f << "deads.mean,deads.stddev,deads.min,deads.max,"
					f << "dists.mean,dists.stddev,dists.min,dists.max,"
					f << "\n"
					(1..max_size).each do |msx|
						(1..msx).each do |msy|
							times, deads, dists = [], [], []
							trials.times do |t|
								s = Cartesian::Space.new x: msx, y: msy
								bm = Benchmark.measure do
									a.act_on space: s
								end
								times << [
									bm.utime,
									bm.cutime,
									bm.stime,
									bm.cstime,
									bm.real,
									bm.total,
								]
								deads << s.deadends.count
								dists << s[x: 0, y: 0].distances.max_path.farthest[1]
								if verbose
									puts <<-EOS
#{a.to_s} #{msx.to_s.rjust(jm, "0")} #{msy.to_s.rjust(jm, "0")} \
#{t.to_s.rjust(2, "0")} #{bm.real}
									EOS
								end
							end
							f << "#{msx.to_s.rjust(jm, "0")},"
							f << "#{msy.to_s.rjust(jm, "0")},"
							6.times do |tt|
								r = []
								times.each do |time|
									r << time[tt]
								end
								f << "#{r.mean},#{r.standard_deviation},#{r.min},#{r.max},"
							end
							f << "#{deads.mean},#{deads.standard_deviation},"
							f << "#{deads.min},#{deads.max},"
							f << "#{dists.mean},#{dists.standard_deviation},"
							f << "#{dists.min},#{dists.max},"
							f << "\n"
						end
					end
					f << "\n"
				end
			end
		end

	end
end
