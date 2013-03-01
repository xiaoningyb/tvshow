# -*- coding: utf-8 -*-
BASE_URL = 'http://www.tvmao.com'
TV_STATIONS_URL = 'http://tvmao.com/help/tvstation_list.jsp'
START_URL = "#{BASE_URL}/xiaoi/"

CCTV_KEY_WORDS = Set["CCTV"]
HMT_KEY_WORDS = Set["香港", "澳门", "台湾"]
OVERSEA_KEY_WORDS = Set["海外"]

SPORTS_KEY_WORDS = Set["体育", "足球", "篮球", "赛车", "车迷", "高尔夫", "网球", "汽摩", "围棋", "台球", "武术", "垂钓", 
                       "ESPN", "钓鱼", "球王", "球迷", "Sports", "板球", "运动", "網球", "高球"]
MOVIES_KEY_WORDS = Set["电影", "剧场", "HBO", "CINEMAX", "Movie", "電影", "影剧", "影视"]

PROGRAM_NAME_CHOP_NAME = Set["译制片:", "故事片:", "电视剧:"]

class CrawlerInfo < ActiveRecord::Base
  attr_accessible :begin, :crawl_link_counter, :crawl_page_counter, :end, :group_counter, :new_group_counter, 
                  :new_program_counter, :new_station_counter, :program_counter, :station_counter

  def self.start_crawl
    @agent = Mechanize.new
    @station_find_num = 0
    @station_add_num = 0

    page = @agent.get(START_URL)
    page.search('html/body/div.clear/table/tr/td/a').each do |classic|
      puts classic.content
      if CCTV_KEY_WORDS.include?(classic.content)
        self.crawl_station_classic(classic, 'cctv')
      elsif HMT_KEY_WORDS.include?(classic.content)
        self.crawl_station_classic(classic, 'hmt_tv')
      elsif OVERSEA_KEY_WORDS.include?(classic.content)
        self.crawl_station_classic(classic, 'oversea_tv')
      else
        self.crawl_station_classic(classic, 'local_tv')
      end
    end

    #print the crawl info
    puts "find " + @station_find_num.to_s + " station, and added " + @station_add_num.to_s + " station."
  end

  def self.crawl_station_classic(classic, group_name)
    href = classic['href']
    sleep(1)
    page = @agent.get(href)            
    stations = []

    #crawl sub classic
    self.crawl_sub_classic!(stations, page, href)
    
    self.add_new_station_to_group(stations, group_name)

    self.update_stations_schedule(stations)
  end
 
  def self.crawl_sub_classic!(stations, page, href)
    #push first station in sub classic
    stations << {:name => page.search('/html/body/div/div/ul/li/b')[0].content, 
                 :en_name => href[href.index('-')+1 .. href.rindex('-')-1], 
                 :url => href}
    @station_find_num = @station_find_num + 1

    #find first class stations
    page.search('/html/body/div/div/ul/li/a').each do |station|
      href = station['href']
      stations << {:name => station.ancestors[0].content, 
                   :en_name => href[href.index('-')+1 .. href.rindex('-')-1], 
                   :url => href}
      @station_find_num = @station_find_num + 1
    end

    #find other group
    page.search('/html/body/div/div/a/@href').each do |sub|
      sleep(1)
      group_page = @agent.get(BASE_URL + sub)

      #add the first element
      href = sub.to_s
      stations << {:name => group_page.search('/html/body/div/div/ul/li/b')[0].content, 
                   :en_name => href[href.index('-')+1 .. href.rindex('-')-1], 
                   :url => sub}
      #add the others
      group_page.search('/html/body/div/div/ul/li/a').each do |station|
        href = station['href']
        stations << {:name => station.ancestors[0].content, 
                     :en_name => href[href.index('-')+1 .. href.rindex('-')-1], 
                     :url => href}
        @station_find_num = @station_find_num + 1
      end
    end

  end

  def self.add_new_station_to_group(stations, group_name)
    stations.each do |station|
      if TvStation.where(:en_name => station[:en_name]).all.empty?
        puts station[:name] + ", en_name = " + station[:en_name] + ", url = " +  station[:url]
        station = TvStation.create(:name => station[:name], :en_name => station[:en_name], :description => station[:name])
        @station_add_num = @station_add_num + 1
        
        group = TvGroup.where(:en_name => group_name)[0]
        group.tv_stations << station
        
        if self.is_sports_tv?(station[:name])
          group = TvGroup.where(:en_name => "sports_tv")[0]
          group.tv_stations << station
        elsif self.is_movie_tv?(station[:name])
          group = TvGroup.where(:en_name => "movie_tv")[0]
          group.tv_stations << station
        end
      else
        #puts station[:en_name] + " has been added."
      end

    end
  end

  def self.is_sports_tv?(name)
    SPORTS_KEY_WORDS.each do |key|
      if name.include?(key)
        return true
      end
    end
    return false
  end 

  def self.is_movie_tv?(name)
    MOVIES_KEY_WORDS.each do |key|
      if name.include?(key)
        return true
      end
    end
    return false
  end 

  def self.update_stations_schedule(stations)
    stations.each do |station|
      #get tv station info
      st_data = TvStation.where(:en_name => station[:en_name]).all[0]

      #check if need to updated the programs
      if not (st_data.updated_date != nil) && (st_data.updated_date >= Time.now.to_date + 7)
        self.update_station_schedule(station, st_data)        
      end
    end
  end
  
  def self.update_station_schedule(station, st_data)
    sleep(1)
    page = @agent.get(station[:url])

    #get the base href
    href = page.search('/html/body/div/div/nav/a/@href')[0].to_s
    base_href = href[0 .. href.rindex('-')]
      
    #get the begin date in web
    str = page.search('/html/body/div/div/nav/a')[0]['title'].delete("节目表")
    begin_date = Date.parse(str.gsub("年", "-").gsub("月", "-").gsub("日", ""))
    
    #compute the range for geting programg schedule
    begin_idx = 1 
    if st_data.updated_date != nil
      begin_idx = st.updated_date - begin_date + 2
    end
    end_idx = Time.now.to_date + 8 - begin_date
    
    #get program schedule by href
    begin_idx.step(end_idx, 1).each do |idx|
       update_station_schedule_by_date(station, st_data, begin_date+idx-1,  base_href + "w" + idx.to_s + ".html")
    end
    
    #update the st info
    #st_data.updated_date = Time.now.to_date + 7
    st_data.save    
  end

  def self.update_station_schedule_by_date(station, st_data, date, href)
    page = @agent.get(href)

    page.search('/html/body/div/div/div/ul/li').each do |program|
      name = ""
      next_name = ""
      begin_time_str = ""
      end_time_str = ""
      episode = ""
      next_episode = ""

      if program.children.size != 1
        self.get_program_info!(program, name, begin_time_str, episode)
        if (program.next_sibling != nil)
          self.get_program_info!(program.next_sibling, next_name, end_time_str, next_episode)
        else
          end_time_str = '23:59'
        end
        begin_time = Time.parse(date.to_s + " " + begin_time_str + ":00 +0800")
        end_time = Time.parse(date.to_s + " " + end_time_str + ":00 +0800")
        pro = TvProgram.create(:name => name, :description => name)
        TvProgramship.create(:tv_station => st_data, :tv_program => pro, :begin => begin_time, :end => end_time)
        puts name + " : " + begin_time_str + "~" + end_time_str
      end

    end
  end

  def self.get_program_info!(program, name, time, episode)
    #program
    if program == nil
      name.replace("")
      time.replace("23:59")
      episode.replace("")
      return
    end

    #parse the tv program info 
    if program.children.size == 1
       self.get_program_info!(program.next_sibling, name, time, episode)
    elsif program.children.size == 2
      time.replace(program.children[0].content.strip)
      name.replace(program.children[1].content.strip)
    elsif (program.children.size == 11) || (program.children.size == 10)
      time.replace(program.children[0].text.strip)
      name.replace(program.children[2].text.strip)
      episode = program.children[4].content.strip
    else
      time.replace(program.children[0].content.strip)
      name.replace(program.children[2].content.strip)
    end 
  end
  
end
