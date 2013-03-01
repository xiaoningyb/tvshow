class TvProgramship < ActiveRecord::Base
  attr_accessible :begin, :end, :tv_program_id, :tv_station_id, :tv_station, :tv_program

  #relationship between tv_station <-> tv_program
  belongs_to :tv_station
  belongs_to :tv_program

  validates_presence_of :tv_station_id
  validates_presence_of :tv_program_id
end
