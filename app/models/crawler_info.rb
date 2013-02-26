# -*- coding: utf-8 -*-
BASE_URL = 'http://www.tvmao.com'
TV_STATIONS_URL = 'http://tvmao.com/help/tvstation_list.jsp'
START_URL = "#{BASE_URL}/xiaoi/"

SPORTS_TV_STATIONS = Set["CCTV5", "CCTVPAYFEE13", "CCTVPAYFEE22", "TIANYUANWEIQI", "CCTVPAYFEE36", "WUSHUSHIJIE",
                         "KUAILECHUIDIAO", "XFBY"]

class CrawlerInfo < ActiveRecord::Base
  attr_accessible :begin, :crawl_link_counter, :crawl_page_counter, :end, :group_counter, :new_group_counter, 
                  :new_program_counter, :new_station_counter, :program_counter, :station_counter

  def self.start_crawl
    @agent = Mechanize.new

    #start crawl the tv station
    self.crawl_tv_station

    #start crawl the tv program
    page = @agent.get(START_URL)
    puts page.title
  end

  def self.crawl_tv_station
    page = @agent.get(START_URL)
    num = 0
    
    stations = []
    stations << {:name => "CCTV-1综合频道", :en_name => "CCTV1", :url => "/xiaoi/program/CCTV-CCTV1-w1.html"}

    #find cctv stations
    page.search('/html/body/div/div/ul/li/a').each do |station|
      href = station['href']
      stations << {:name => station.content, :en_name => href[href.index('-')+1 .. href.rindex('-')-1], :url => href}
    end

    #find other group
    page.search('/html/body/div/div/a/@href').each do |group|
      group_page = @agent.get(BASE_URL + group)
      group_page.search('/html/body/div/div/ul/li/a').each do |station|
        href = station['href']
        stations << {:name => station.content, :en_name => href[href.index('-')+1 .. href.rindex('-')-1], :url => href}
      end
    end

    stations.each do |station|
      if TvStation.where(:en_name => station[:en_name]).all.empty?
        puts station[:name] + ", en_name = " + station[:en_name] + ", url = " +  station[:url]
        station = TvStation.create(:name => station[:name], :en_name => station[:en_name], :description => station[:name])
        num = num + 1
        
        group = TvGroup.where(:en_name => "cctv")[0]
        group.tv_stations << station
        
        if SPORTS_TV_STATIONS.include?(station[:en_name])
          group = TvGroup.where(:en_name => "sports_tv")[0]
          group.tv_stations << station
        end
        
      end
    end
    puts "find " + stations.size.to_s + " station, and added " + num.to_s + " station."

  end

end
