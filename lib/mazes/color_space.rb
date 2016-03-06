module Mazes
# Adds color capabilities to a Space. This is currently based solely on Distance
# mapping and thus on Cell linkage, and is therefore not directly dependent on
# local geometry. It must be included AFTER DistanceMap, as it overrides the
# distances writer.
	module ColorSpace
		require "chunky_png"

# Public: Assign a Distances map to the Space for use in color mapping.
#
# distances - A Distances instance.
		def distances= distances
			@distances = distances
			@farthest, @maximum = @distances.max_path
		end

# Public: Retreive a background color for a Cell to be used in rendering.
#
# cell - A Cell to query for background coloring.
# algo - A Symbol referencing a specific coloring algorithm to use. Defaults to
#   :rotate_hue
#
# Returns a ChunkyPNG::Color or nil
		def bg_color_for cell:, algo: :rotate_hue
			self.send(algo, cell: cell)
		end

# Public: Calculate background colors by rotating hues along the color wheel as
# distance increases.
#
# cell - A Cell to query for background coloring.
# scalar - A Number that determines how many cycles of the color wheel are in
#   the longest path of the Space. Defaults to 1.25
#
# Returns a ChunkyPNG::Color or nil
require "pry"
		def rotate_hue cell:, scalar: 1.25
			return nil if @distances.nil? or @distances[cell].nil?
			distance = @distances[cell]
			hue = (360 * distance * scalar / @maximum).round % 360
			sat = 1.0
			lum = 0.5
			ChunkyPNG::Color.from_hsl hue, sat, lum
		end

	end
end
