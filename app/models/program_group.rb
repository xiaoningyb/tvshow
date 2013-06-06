class ProgramGroup < ActiveRecord::Base
  attr_accessible :description, :image, :interval, :key_word, :name, :total_episode, :discusses,
                  :group_type, :tv_programs, :watch_count, :discuss_count, :checkin_count, :program_type

  has_many :tv_programs

  #for watch relationship with user
  has_many :user_programships, :dependent => :destroy, :as => :program
  has_many :watch_users, :through => :user_programships, :source => :user, :uniq => true

  #for checkin relationship with user
  has_many :user_checkinships, :dependent => :destroy, :as => :program
  has_many :checkin_users, :through => :user_checkinships, :source => :user, :uniq => true

  #for relationship with discuss
  has_many :discusses, :as => :program

end
