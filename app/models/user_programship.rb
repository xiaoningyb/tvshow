class UserProgramship < ActiveRecord::Base
  attr_accessible :program_id, :program_type, :user_id, :program, :user, :time

  #watch relationship between tv_program <-> user
  belongs_to :user
  belongs_to :program, :polymorphic => true

end
