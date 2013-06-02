class ProgramGroup < ActiveRecord::Base
  attr_accessible :description, :image, :interval, :key_word, :name, :total_episode, 
                  :group_type, :tv_programs

  has_many :tv_programs
end
