class GeoLine < ActiveRecord::Base
  attr_accessible :name, :delay, :geo_point_ids, :end_of_line, :step_of_post

  has_many :geo_points

  def geo_points_coordinates
    objects_to_array(geo_points)
  end

  def part_coordinates_of_geo_points(time, step_time)
    time_begin = time - step_time
    time_end = time

    part_geo_points = geo_points.where("created_at >= :time_begin AND created_at <= :time_end", time_begin: time_begin, time_end: time_end)

    objects_to_array(part_geo_points)
  end

  def part_geo_points(time, step_time)
    time_begin = time - step_time
    time_end = time

    geo_points.where("created_at >= :time_begin AND created_at <= :time_end", time_begin: time_begin, time_end: time_end)
  end

  def full_geo_points
    objects_to_array(geo_points)
  end

  def objects_to_array(geo_points)
    geo_points.select('lat, lon').collect{ |geo|[geo.lat.to_f, geo.lon.to_f] }
  end
end
