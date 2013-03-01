class TvStationsController < ApplicationController
  #before_filter :authenticate_user!, :except => [:index, :show]

  #show index page
  def index
    if (params[:cmd] != nil) && (params[:cmd] == "detail")
      index_detail(params)
    elsif
      index_simple
    end     
  end

  #new tv station, it will be deprecated
  def new
    @station = TvStation.new
  end
  
  #new tv station using POST method
  def create
    create_station_in_group(params)
    
    redirect_to :action => :index
  end

  def index_simple
    @stations = TvStation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @stations.to_xml }
      format.json { render :json => @stations.to_json }
    end
  end

  def index_detail(params)
    @stations = TvStation.all
    @station_infos = []
    @stations.each do |station|
      @station_infos << self.get_program_now(station)
    end
    respond_to do |format|
      format.xml { render :xml => @station_infos.to_xml }
      format.json { render :json => @station_infos.to_json }
    end
  end

  #show tv group info
  def show
    if (params[:date] != nil)
      show_one_day(params)
    elsif ((params[:begin] != nil) && (params[:end] != nil))
      show_time_interval(params)
    elsif (params[:offset] != nil)
      show_date_offset(params)
    else
      show_simple(params)
    end
  end    

  def show_simple(params)
    @station = TvStation.find(params[:id])
    @programs = @station.get_programs()

    @programs_format = self.format_json(@station, @programs)
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @programs_format.to_xml }
      format.json { render :json => @programs_format.to_json }
    end
  end

  def show_one_day(params)
    @station = TvStation.find(params[:id])
    start_time = DateTime.parse(params[:date] + " 00:00:00 +0800")
    end_time = 1.days.since(start_time)
    @programs = @station.get_programs_by_interval(start_time, end_time)

    @programs_format = self.format_json(@station, @programs)
    @programs_format[:date] = start_time.to_date
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @programs_format.to_xml }
      format.json { render :json => @programs_format.to_json }
    end
  end

  def show_time_interval(params)
    @station = TvStation.find(params[:id])
    start_time = DateTime.parse(params[:begin])
    end_time = DateTime.parse(params[:end])
    @programs = @station.get_programs_by_interval(start_time, end_time)

    @programs_format = self.format_json(@station, @programs)
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @programs_format.to_xml }
      format.json { render :json => @programs_format.to_json }
    end
  end

  def show_date_offset(params)
    @station = TvStation.find(params[:id])
    date_offset = params[:offset].to_i
    @programs = @station.get_programs_by_offset(date_offset)

    @programs_format = self.format_json(@station, @programs)    
    @programs_format[:date] = Date.today

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @programs_format.to_xml }
      format.json { render :json => @programs_format.to_json }
    end
  end

  def get_program_now(station)
    programs = station.get_programs_now()    
    return self.format_json(station, programs)
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

  #format function
  def format_json(station, programs_info)
    #format station info
    station_format = {}
    station_format[:station_name] = station.name
    station_format[:station_id] = station.id
    station_format[:image] = station.image
    station_format[:banner] = station.banner    

    #format programs info
    programs_format = []
    programs_info.each do |programship, program|
      program_format = { :program_id => program.id, :name => program.name, :description => program.description, :episode => program.episode, 
                         :image => program.image, :key_word => program.key_word, :begin => programship.begin, :end => programship.end, 
                         :watch_count => program.watch_count, :discuss_count => program.discuss_count, :checkin_count => program.checkin_count}
      programs_format << program_format
    end

    station_format[:programs] = programs_format

    return station_format
  end

  #create the station with group
  def create_station_in_group(params)
    TvStation.transaction do
      @station = TvStation.new(params[:tv_station])
      @station.save      
      if (params[:group] != nil) and (params[:group][:group_id] != nil)
        group = TvGroup.find(params[:group][:group_id])
        if group != nil
          TvGroupship.create(:tv_group => group, :tv_station => @station)
        end
      end
    end
  end  

end
