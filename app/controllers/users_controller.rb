class UsersController < ApplicationController

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
    @user = User.find(params[:id])

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
