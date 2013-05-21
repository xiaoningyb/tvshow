class CrawlProgramContentController < ApplicationController
    
  #new page for crawling infomation about tv_program
  def create
    @program = TvProgram.find(params[:tv_program][:id])
    @program.transaction do 
      @program.update_attributes(:name => params[:tv_program][:name])
      @program.update_attributes(:description => params[:tv_program][:description])
    end

    redirect_to :controller=>"tv_programs", :action => :show, :id => @program
  end

  #new page for crawl info
  def new
    @user = User.find(params[:user])
    @program = TvProgram.find(params[:program])

    crawler = CrawlProgramContentHelper::Baike.new

    crawler.start_crawl_keyword(@program.name)

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => program.to_xml }
      format.json { render :json => program.to_json }
    end
  end

end
