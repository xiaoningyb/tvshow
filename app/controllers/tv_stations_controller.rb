class TvStationsController < ApplicationController

 #show index page
  def index
    @stations = TvStation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @stations.to_xml }
      format.json { render :json => @stations.to_json }
    end
  end

  #new tv station, it will be deprecated
  def new
    @station = TvStation.new
  end
  
  #new tv station using POST method
  def create
    @station = TvStation.new(params[:station])
    @station.save
    
    redirect_to :action => :index
  end

  #show tv group info
  def show
    @station = TvStation.find(params[:id])
    @programs = @station.tv_programs

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @programs.to_xml }
      format.json { render :json => @programs.to_json }
    end
  end

  #edit tv group, it will be deprecated
  def edit
    @station = TvStation.find(params[:id])
  end

  #update tv group using PUT method
  def update
    @station = TvStation.find(params[:id])
    @station.update_attributes(params[:station])
  
    redirect_to :action => :show, :id => @station
  end

  #delete tv group using DELETE method
  def destroy
    @station = TvStation.find(params[:id])
    @station.destroy
    
    redirect_to :action => :index
  end

end
