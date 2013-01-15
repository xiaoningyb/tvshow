class DiscussesController < ApplicationController
  
  #show discusses index page
  def index
    @discuss = Discuss.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render; :xml => @discuss.to_xml }
      format.json { render :json => @discuss.to_json }
    end
  end

  #new discuss, it will be deprecated
  def new
    @discuss = Discuss.new
  end
  
  #new discuss using POST method
  def create
    @discuss = Discuss.new(params[:discuss])
    @discuss.save
    
    redirect_to :action => :index
  end

  #show discuss info
  def show
    @discuss = Discuss.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @discuss.to_xml }
      format.json { render :json => @discuss.to_json }
    end
  end

  #edit discuss, it will be deprecated
  def edit
    @discuss = Discuss.find(params[:id])
  end

  #update discuss using PUT method
  def update
    @discuss = Discuss.find(params[:id])
    @discuss.update_attributes(params[:discuss])
  
    redirect_to :action => :show, :id => @discuss
  end

  #delete discuss using DELETE method
  def destroy
    @discuss = Discuss.find(params[:id])
    @discuss.destroy
    
    redirect_to :action => :index
  end

end
