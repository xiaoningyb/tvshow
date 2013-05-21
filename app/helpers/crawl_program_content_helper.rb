module CrawlProgramContentHelper
  
  class Baike
    BAIKE_BASE_URL = 'http://wapbaike.baidu.com'
    def start_crawl_keyword(keyword)
      #create agent
      @agent = Mechanize.new

      #file info
      @agent.request_headers['Referer'] = BAIKE_BASE_URL
      @agent.user_agent_alias = 'Mac Safari'

      #find group info
      url = BAIKE_BASE_URL + '/search?word=' + URL_encode(keyword) + '&submit=%E8%BF%9B%E5%85%A5%E8%AF%8D%E6%9D%A1&uid=08371E472DF23E320426A716C6767656&ssid=&st=1&bk_fr=srch&bd_page_type=1'
      page = @agent.get(url)
      
      puts page.content

    end
    
    def URL_decode(str)
      str.gsub!(/%[a-fA-F0-9]{2}/) { |x| x = x[1..2].hex.chr }
    end

    def URL_encode(str)
      str.gsub!(/[^\w$&\-+.,\/:;=?@]/) { |x| x = format("%%%x", x[0]) }
    end
    
  end

end
