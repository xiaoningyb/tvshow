class TvStation < ActiveRecord::Base
  attr_accessible :name, :en_name, :description, :image, :image_url, :banner, :banner_url, :updated_date

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
          if programship.begin <= time and time <= programship.end
            programs[programship] = program
          end
        end
      end
    end
    return programs
  end

  #get programs
  def get_programs_by_interval(start_time, end_time)
    programs = {}
    self.tv_programs.each do |program|
      self.tv_programships.each do |programship|
        if program.id == programship.tv_program_id
          if programship.begin >= start_time and programship.begin <= end_time
            programs[programship] = program
          end
        end
      end
    end
    return programs
  end

  #get programs
  def get_programs_by_offset(date_offset)
    programs = {}
    self.tv_programs.each do |program|
      self.tv_programships.each do |programship|
        if program.id == programship.tv_program_id
          if programship.begin >= (Date.today + date_offset).to_time and programship.begin <= (Date.today + date_offset + 1).to_time
            programs[programship] = program
          end
        end
      end
    end
    return programs
  end

  #get programs
  def get_programs_now()
    return get_programs_by_time(Time.now)
  end


end
