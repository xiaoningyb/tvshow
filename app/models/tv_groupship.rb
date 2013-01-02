class TvGroupship < ActiveRecord::Base
  attr_accessible :tv_group_id, :tv_station_id
  belongs_to :tv_station, :foreign_key => "tv_station_id"
  belongs_to :tv_group, :foreign_key => "tv_group_id"
end
