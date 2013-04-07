# -*- coding: utf-8 -*-
module WebCawler

  CNTV_BASE_URL = 'http://tv.cntv.cn'
  CNTV_START_URL = "#{CNTV_BASE_URL}/epg/"
  STATION_CLASSIC = { "央视" => "cctv", "卫视" => "local_tv", "数字" => "digit_tv", "CETV" => "cctv", "城市" => "city_tv"}
  SPORTS_KEY_WORDS = Set["体育", "足球", "篮球", "赛车", "车迷", "高尔夫", "网球", "汽摩", "围棋", "台球", "武术", "垂钓", 
                         "ESPN", "钓鱼", "球王", "球迷", "Sports", "板球", "运动", "網球", "高球"]
  MOVIES_KEY_WORDS = Set["电影", "剧场", "HBO", "CINEMAX", "Movie", "電影", "影剧", "影视"]

  class Cntv

    def start_crawl_stations
      #create agent
      @agent = Mechanize.new
      @crawl_info = CrawlerInfo.new
      @crawl_info.begin_crawl

      #file info
      @agent.request_headers['Referer'] = CNTV_START_URL
      @agent.user_agent_alias = 'Mac Safari'

      #find group info
      page = @agent.get(CNTV_START_URL)
      classic_name = []
      page.search('html/body/div/div/div/div/div/div/div/div/div/div/div/ul/li/a').each do |classic|
        classic_name << classic.text
        @crawl_info.inc_group_counter
      end

      index = 0;
      page.search('html/body/div/div/div/div/div/div/div/div/div/div/div/dl').each do |classic|
        classic.search('dd/h3/a').each do |tv|
          if (tv['title'] != nil) && (tv['rel'] != nil)
            #puts "find tv name = "+ tv['title'].to_s + ", en_name = " + tv['rel'].to_s + " in " + classic_name[index]
            @crawl_info.inc_station_counter
            add_new_stations(tv['title'], tv['rel'], STATION_CLASSIC[classic_name[index]])
          end
        end
        index += 1
      end

      puts "Total find " + @station_find_num.to_s + ", add " + @station_add_num.to_s + " new stations."
    end

    def add_new_stations(name, en_name, group_name)
      #check the station exist
      if TvStation.where(:en_name => en_name).all.empty?
        puts "add new tv name = "+ name + ", en_name = " + en_name + " in gourp = " + group_name
        station = TvStation.create(:name => name, :en_name => en_name, :description => name)
        @crawl_info.inc_new_station_counter
        
        #add to group
        group = TvGroup.where(:en_name => group_name)[0]
        group.tv_stations << station
        
        #for sports/movie group
        if self.is_sports_tv?(station[:name])
          group = TvGroup.where(:en_name => "sports_tv")[0]
          group.tv_stations << station
        elsif self.is_movie_tv?(station[:name])
          group = TvGroup.where(:en_name => "movie_tv")[0]
          group.tv_stations << station
        end
      else
        puts en_name + " has been added."
      end      
    end

    def is_sports_tv?(name)
      SPORTS_KEY_WORDS.each do |key|
        if name.include?(key)
          return true
        end
      end
      return false
    end 

    def is_movie_tv?(name)
      MOVIES_KEY_WORDS.each do |key|
        if name.include?(key)
          return true
        end
      end
      return false
    end

    def end_crawl_programs
      @crawl_info.end_crawl
    end

    def start_crawl_programs
      @agent = Mechanize.new
      @agent.request_headers['x-requested-with'] = 'XMLHttpRequest' 
      @agent.request_headers['Referer'] = CNTV_START_URL
      @agent.user_agent_alias = 'Mac Safari'

      TvStation.all.each do |station|        
        if station != nil
          #check if need to updated the programs
          sleep(10)
          puts "Start the crawl the program in station : " + station.name
          update_station_schedule(station)
        end
      end
    end

    def update_station_schedule(station)
      #if do not have updated info, using 3 days before today
      if station.updated_date == nil
        station.updated_date = Time.now.to_date - 3
      end

      while (station.updated_date <= Time.now.to_date + 3)
        crawl_date = station.updated_date + 1
        @crawl_info.set_current_station(station.name + "(" + crawl_date.to_s + ")")
        puts "update data :" + station.updated_date.to_s
        url = "#{CNTV_BASE_URL}/index.php?action=epg-list&date=#{crawl_date.to_s}&channel=#{station.en_name}&mode="
        
        puts "start crawl " + url
        begin
          page = @agent.get(url)
        rescue Mechanize::ResponseReadError => e
          puts "Mechanize::ResponseReadError"
          page = e.force_parse
        end
        
        if page.content == "0"
          puts "crawl #{url} failed!"
        else
          if parse_station_schedule(page, station, crawl_date)
            station.updated_date = crawl_date
            station.save
          end
        end        
        sleep(10)
      end      
    end

    def parse_station_schedule(page, st, date)
      programs = page.search('div/div/div/dl/dd')
      idx = 0
      programs.each do |program|
        name = ""
        next_name = ""
        begin_time_str = ""
        end_time_str = ""
        episode = ""
        next_episode = ""

        @crawl_info.inc_program_counter
        get_program_info!(program, name, begin_time_str, episode)
        if (idx < (programs.size-1))
          get_program_info!(programs[idx+1], next_name, end_time_str, next_episode)
        else
          end_time_str = '23:59'
        end

        #try to find same program in database
        tv_pros = TvProgram.where(:name => name).all        
        if tv_pros.empty?
          pro = TvProgram.create(:name => name, :description => name)
        else
          pro = tv_pros[0]
        end
        
        #create the program
        begin_time = Time.parse(date.to_s + " " + begin_time_str + ":00 +0800")
        end_time = Time.parse(date.to_s + " " + end_time_str + ":00 +0800")
        TvProgramship.create(:tv_station => st, :tv_program => pro, :begin_time => begin_time, :end_time => end_time)
        @crawl_info.inc_new_program_counter
        @crawl_info.set_current_program(pro.name)

        puts begin_time.to_s + " ~ " +  end_time.to_s + " : " + name

        idx += 1
      end
    end

    def get_program_info!(program, name, time, episode)
      #puts program
      program_str = program.content
      program_str = program_str[program_str.index(":")-2 .. program_str.length].strip
      
      time.replace(program_str[0 .. program_str.index(" ")-1])
      name.replace(program_str[program_str.index(" ")+1 .. program_str.length])
    end
    
  end
end
