require 'rubygems'
require 'rufus/scheduler' 
require 'web_crawler' 

scheduler = Rufus::Scheduler.start_new
#CrawlerInfo.start_crawl

scheduler.every '1d', :first_in => '5s' do
  crawler = WebCawler::Cntv.new

  crawler.start_crawl_stations

  crawler.start_crawl_programs

  crawler.end_crawl_programs
end
