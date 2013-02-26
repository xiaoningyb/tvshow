BASE_URL = 'http://www.tvmao.com'
TV_STATIONS_URL = 'http://tvmao.com/help/tvstation_list.jsp'
START_URL = "#{BASE_URL}/xiaoi/"

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
    page = @agent.get(TV_STATIONS_URL)
    num = 0
    page.search('/html/body/div/ul/li').each do |station|
      puts station.content
      num = num + 1
    end
    puts num
  end

end
