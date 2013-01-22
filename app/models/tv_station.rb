class TvStation < ActiveRecord::Base
  attr_accessible :description, :image, :name
  #for relationship with tv_group
  has_many :tv_groupships, :dependent => :destroy
  has_many :tv_groups, :through => :tv_groupships, :uniq => true
  #for relationship with tv_program
  has_many :tv_programships, :dependent => :destroy
  has_many :tv_programs, :through => :tv_programships, :uniq => true

  #get programs
  def get_programs
    programs = {}
    self.tv_programs.each do |program|
      self.tv_programships.each do |programship|
        if program.id == programship.tv_program_id
          programs[programship] = program
        end
      end
    end
    return programs
  end

 #get programs
  def get_programs_by_time(time)
    programs = {}
    self.tv_programs.each do |program|
      self.tv_programships.each do |programship|
        if program.id == programship.tv_program_id
          #for debug
          if programship.begin <= time and time <= programship.end
            programs[programship] = program
          end
        end
      end
    end
    return programs
  end

end
