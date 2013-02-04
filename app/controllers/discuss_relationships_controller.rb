class DiscussRelationshipsController < ApplicationController
  #before_filter :authenticate_user!, :except => [:index, :show]

  #new discuss, it will be deprecated
  def new
    @discuss = Discuss.new(:user => current_user, :time => Time.now)
    @src = nil
    if params[:src] != nil
      @src = Discuss.find(params[:src])
    end
    @program = TvProgram.find(params[:program])
  end

  def create
    params[:discuss][:time] = Time.now
    @discuss = Discuss.new(params[:discuss])
    @src = nil
    if params[:src] != nil
      @src = Discuss.find(params[:src])
    end
    @program = TvProgram.find(params[:program_id])
    DiscussRelationshipsController.create_relationship(current_user, @src, @discuss, @program)

    redirect_to :controller => "tv_programs", :action => :show, :id => @program
  end

  def destory
    @discuss = Discuss.find(params[:src])
    @source = Discuss.find(params[:quote])
    @program = TvProgram.find(params[:program])
    DiscussRelationshipsController.destory_relationsip(current_user, @src, @discuss, @program)
  end

  def self.create_relationship(user, source, discuss, program)
    if user == nil || discuss == nil || program == nil
      return
    end

    discuss.transaction do 
      user.update_attributes(:discuss_count => user.discuss_count.next)
      discuss.update_attributes(:tv_program => program)
      discuss.update_attributes(:user => user)
      program.update_attributes(:discuss_count => program.discuss_count.next)
      if source != nil
        source.update_attributes(:quote_count => discuss.quote_count.next)      
        discuss.update_attributes(:discuss_type => 1)
        discuss.update_attributes(:src_id => source.id)
        DiscussRelationship.create(:src => source, :quote => discuss, :time => Time.now)
      end
      discuss.save
    end
  end

  def self.destory_relationship(user, source, discuss, program)
    if user == nil || discuss == nil || program == nil
      return
    end

    discuss.transaction do
      user.update_attributes(:discuss_count => (user.discuss_count-1) )
      discuss.update_attributes(:tv_program => nil)
      discuss.update_attributes(:user => nil)
      program.update_attributes(:discuss_count => (program.discuss_count-1) ) 
      if source != nil
        source.update_attributes(:quote_count => (souce.quote_count-1) )
        discuss.update_attributes(:discuss_type => 0)
        discuss.update_attributes(:src_id => nil)
        DiscussRelationship.destory(:src => source, :quote => discuss)
      end
    end
  end

end
