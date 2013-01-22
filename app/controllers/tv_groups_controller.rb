class TvGroupsController < ApplicationController

  #show index page
  def index
    @groups = TvGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @groups.to_xml }
      format.json { render :json => @groups.to_json }
    end
  end

  #new tv group, it will be deprecated
  def new
    @group = TvGroup.new
  end
  
  #new tv group using POST method
  def create
    @group = TvGroup.new(params[:tv_group])
    @group.save
    
    redirect_to :action => :index
  end

  #show tv group info
  def show
    if (params[:cmd] != nil) && (params[:cmd] == "detail")
      show_detail(params)
    elsif
      show_simple(params)
    end      
  end

  #edit tv group, it will be deprecated
  def edit
    @group = TvGroup.find(params[:id])
  end

  #update tv group using PUT method
  def update
    @group = TvGroup.find(params[:id])
    @group.update_attributes(params[:group])
  
    redirect_to :action => :show, :id => @group
  end

  #delete tv group using DELETE method
  def destroy
    @group = TvGroup.find(params[:id])
    @group.destroy
    
    redirect_to :action => :index
  end

  #show simple 
  def show_simple(params)
    @group = TvGroup.find(params[:id])
    @stations = @group.tv_stations

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @stations.to_xml }
      format.json { render :json => @stations.to_json }
    end
  end

  #show detail
  def show_detail(params)
    @group = TvGroup.find(params[:id])
    @stations = @group.tv_stations
    @station_cur_programs = {}
    @stations.each do |station|      
      @station_cur_programs[station] = station.get_programs_by_time(Time.now)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @stations.to_xml }
      format.json { render :json => @stations.to_json }
    end
  end

end
