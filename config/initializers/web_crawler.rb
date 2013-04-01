require 'rubygems'
require 'rufus/scheduler' 
require 'web_crawler' 

scheduler = Rufus::Scheduler.start_new
#CrawlerInfo.start_crawl

scheduler.every '4d', :first_in => '1s' do
  crawler = WebCawler::Cntv.new

  crawler.start_crawl
end
