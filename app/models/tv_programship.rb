class TvProgramship < ActiveRecord::Base
  attr_accessible :begin, :duration, :end, :is_alive, :tv_program_id, :tv_station_id

  #relationship between tv_station <-> tv_program
  belongs_to :tv_station
  belongs_to :tv_program
end
