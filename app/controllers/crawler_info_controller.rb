class CrawlerInfoController < ApplicationController

  #show index page
  def index
    @infos = CrawlerInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @infos.to_xml }
      format.json { render :json => @infos.to_json }
    end
  end

  #show crawl info
  def show
    @info = CrawlerInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @info.to_xml }
      format.json { render :json => @info.to_json }
    end
  end

end
