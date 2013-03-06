class UserCheckinship < ActiveRecord::Base
  attr_accessible :time, :tv_program_id, :user_id, :user, :tv_program

  #relationship between tv_station <-> tv_group
  belongs_to :user
  belongs_to :tv_program
end
