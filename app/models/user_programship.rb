class UserProgramship < ActiveRecord::Base
  attr_accessible :program_id, :user_id, :tv_program, :user, :type, :time

  #relationship between tv_station <-> tv_group
  belongs_to :user
  belongs_to :tv_program
end
