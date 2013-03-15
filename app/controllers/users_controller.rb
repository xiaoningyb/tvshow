class UsersController < ApplicationController
  #before_filter :authenticate_user!, :except => [:index, :show]

  #show user index page
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @users.to_xml }
      format.json { render :json => @users.to_json }
    end
  end

  #new user, it will be deprecated
  def new
    @user = User.new
  end
  
  #new tv station using POST method
  def create
    @user = User.new(params[:user])
    @user.save
    
    redirect_to :action => :index
  end

  #show user info
  def show
    if (params[:cmd] != nil) && (params[:cmd] == "detail")
      show_detail(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "followers"))
      show_followers(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "followees"))
      show_followees(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "discusses"))
      show_discusses(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "watch_programs"))
      show_watch_programs(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "checkin_programs"))
      show_checkin_programs(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "followers_detail"))
      show_followers_detail(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "followees_detail"))
      show_followees_detail(params)
    else
      show_simple(params)
    end
  end

  #show simple user info
  def show_simple(params)
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user.to_xml }
      format.json { render :json => @user.to_json }
    end
  end

  #show user followers
  def show_followers(params)
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user.get_followers.to_xml }
      format.json { render :json => @user.get_followers.to_json }
    end
  end

  #show user followees
  def show_followees(params)
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user.get_followees.to_xml }
      format.json { render :json => @user.get_followees.to_json }
    end
  end

  #show user followers detail
  def show_followers_detail(params)
    @user = User.find(params[:id])

    followers_detail = []
    @user.get_followers.each do |follower|     
      follower[:latest_checkin] = follower.get_checkin_programs.order("updated_at").last
      followers_detail << follower
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => followers_detail.to_xml }
      format.json { render :json => followers_detail.to_json }
    end
  end

  #show user followees detail
  def show_followees_detail(params)
    @user = User.find(params[:id])

    followees_detail = []
    @user.get_followees.each do |followee|
      followee[:latest_checkin] = followee.get_checkin_programs.order("updated_at").last
      followees_detail << follower
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => followees_detail.to_xml }
      format.json { render :json => followees_detail.to_json }
    end
  end

  #show user discusses
  def show_discusses(params)
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user.get_discusses.to_xml }
      format.json { render :json => @user.get_discusses.to_json }
    end
  end

  #show user watch programs
  def show_watch_programs(params)
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user.get_watch_programs.to_xml }
      format.json { render :json => @user.get_watch_programs.to_json }
    end
  end

  #show user watch programs
  def show_checkin_programs(params)
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user.get_checkin_programs.to_xml }
      format.json { render :json => @user.get_checkin_programs.to_json }
    end
  end

  #show user detail information
  def show_detail(params)
    @user = User.find(params[:id])
    @user[:followers] = @user.get_followers
    @user[:followees] = @user.get_followees
    @user[:discusses] = @user.get_discusses
    @user[:watch_programs] = @user.get_watch_programs
    @user[:checkin_programs] = @user.get_checkin_programs

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user.to_xml }
      format.json { render :json => @user.to_json }
    end
  end

  #edit user, it will be deprecated
  def edit
    @user = User.find(params[:id])
  end

  #update user using PUT method
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
  
    redirect_to :action => :show, :id => @user
  end

  #delete tv group using DELETE method
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    redirect_to :action => :index
  end
 
end
