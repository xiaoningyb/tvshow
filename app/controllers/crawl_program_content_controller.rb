class CrawlProgramContentController < ApplicationController
    
  #new tv station using POST method
  def create
    # @program = TvProgram.new(params[:program])
    # @program.save
    
    redirect_to :action => :index
  end

  #new page for crawl info
  def new
    @user = User.find(params[:user])
    @program = TvProgram.find(params[:program])
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => program.to_xml }
      format.json { render :json => program.to_json }
    end

  end

end
