# -*- coding: utf-8 -*-

class CrawlerInfo < ActiveRecord::Base
  attr_accessible :begin_time, :crawl_link_counter, :crawl_page_counter, :end_time, :group_counter, :new_group_counter, 
                  :new_program_counter, :new_station_counter, :program_counter, :station_counter  

  def begin_crawl
    self.begin_time = Time.now
    self.save
  end

  def end_crawl
    self.end_time = Time.now
    self.save
  end

  def inc_group_counter
    self.group_counter += 1
    self.save
  end

  def inc_new_group_counter
    self.new_group_counter += 1
    self.save
  end

  def inc_station_counter
    self.station_counter += 1
    self.save
  end

  def inc_new_station_counter
    self.new_station_counter += 1
    self.save
  end

  def inc_program_counter
    self.program_counter += 1
    self.save
  end

  def inc_new_program_counter
    self.new_program_counter += 1
    self.save
  end

end
