class UserCheckinship < ActiveRecord::Base
  attr_accessible :time, :program_id, :program_type, :user_id, :user, :program

  #relationship between tv_station <-> tv_group
  belongs_to :user
  belongs_to :program, :polymorphic => true
end
