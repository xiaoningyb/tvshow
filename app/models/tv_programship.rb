class TvProgramship < ActiveRecord::Base
  attr_accessible :begin, :duration, :end, :is_alive, :tv_program_id, :tv_station_id
end
