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
    self.tv_programships.where("tv_station_id = ?", self.id).each do |programship|
      programs[programship] = TvProgram.find(programship.tv_program.id)
    end
    return programs
  end

  #get programs
  def get_programs_by_time(time)
    programs = {}    
    self.tv_programships.where("tv_station_id = ? and begin <= ? and ? <= end", self.id, time, time).each do |programship|
      programs[programship] = TvProgram.find(programship.tv_program.id)        
    end
    return programs
  end

  #get programs
  def get_programs_by_interval(start_time, end_time)
    programs = {}
    self.tv_programships.where("tv_station_id = ? and begin >= ? and begin <= ?", self.id, start_time, end_time).each do |programship|
      programs[programship] = TvProgram.find(programship.tv_program.id)
    end
    return programs
  end

  #get programs
  def get_programs_by_offset(date_offset)
    programs = {}
    self.tv_programships.where("tv_station_id = ? and begin >= ? and begin <= ?", 
                               self.id, 
                               (Date.today + date_offset).to_time, 
                               (Date.today + date_offset + 1).to_time).each do |programship|
      programs[programship] = TvProgram.find(programship.tv_program.id)
    end
    return programs
  end

  #get programs
  def get_programs_now()
    return get_programs_by_time(Time.now)
  end


end
