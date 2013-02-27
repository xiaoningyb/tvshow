require 'rubygems'
require 'rufus/scheduler'  

scheduler = Rufus::Scheduler.start_new
#CrawlerInfo.start_crawl

scheduler.every '1d', :first_in => '5s' do
  CrawlerInfo.start_crawl
end
