# -*- coding: utf-8 -*-
module WebCawler

  CNTV_BASE_URL = 'http://tv.cntv.cn'
  CNTV_START_URL = "#{CNTV_BASE_URL}/epg/"
  STATION_CLASSIC = { "央视" => "cctv", "卫视" => "local_tv", "数字" => "digit_tv", "CETV" => "cctv", "城市" => "city_tv"}
  SPORTS_KEY_WORDS = Set["体育", "足球", "篮球", "赛车", "车迷", "高尔夫", "网球", "汽摩", "围棋", "台球", "武术", "垂钓", 
                         "ESPN", "钓鱼", "球王", "球迷", "Sports", "板球", "运动", "網球", "高球"]
  MOVIES_KEY_WORDS = Set["电影", "剧场", "HBO", "CINEMAX", "Movie", "電影", "影剧", "影视"]

  class Cntv

    def start_crawl
      @agent = Mechanize.new
      # @agent.request_headers['x-requested-with'] = 'XMLHttpRequest'

      puts "start crawl " + CNTV_START_URL

      page = @agent.get(CNTV_START_URL)
      classic_name = []
      page.search('html/body/div/div/div/div/div/div/div/div/div/div/div/ul/li/a').each do |classic|
        classic_name << classic.text
      end

      index = 0;
      page.search('html/body/div/div/div/div/div/div/div/div/div/div/div/dl').each do |classic|
        puts "===================" + classic_name[index] + "==============="

        classic.search('dd/h3/a').each do |tv|
          if (tv['title'] != nil) && (tv['rel'] != nil)
          puts "find tv name = "+ tv['title'].to_s + ", en_name = " + tv['rel'].to_s + " in " + classic_name[index]
            add_new_stations(tv['title'], tv['rel'], STATION_CLASSIC[classic_name[index]])
          end
        end
        index += 1

      end
    end


    def add_new_stations(name, en_name, group_name)

      if TvStation.where(:en_name => en_name).all.empty?
        puts "add new tv name = "+ name + ", en_name = " + en_name + " in gourp = " + group_name
        station = TvStation.create(:name => name, :en_name => en_name, :description => name)
        
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
    
  end
end
