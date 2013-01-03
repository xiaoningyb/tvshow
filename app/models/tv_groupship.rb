class TvGroupship < ActiveRecord::Base
  attr_accessible :tv_group_id, :tv_station_id
  #relationship between tv_station <-> tv_group
  belongs_to :tv_station
  belongs_to :tv_group
end
