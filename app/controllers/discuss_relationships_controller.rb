class DiscussRelationshipsController < ApplicationController
  before_filter :authenticate_user!

  #new discuss, it will be deprecated
  def new
    @discuss = Discuss.new(:user_id => current_user.id, :time => Time.now)
    @program = TvProgram.find(params[:program])
  end

  def create
    @discuss = Discuss.new(params[:discuss])
    @quote = nil
    if params[:quote] != nil
      @quote = Discuss.find(params[:quote])
    end
    @program = TvProgram.find(params[:program_id])
    DiscussRelationshipsController.create_relationship(@discuss, @quote, @program)

    redirect_to :controller => "tv_programs", :action => :show, :id => @program
  end

  def destory
    @discuss = Discuss.find(params[:src])
    @quote = Discuss.find(params[:quote])
    @program = TvProgram.find(params[:program])
    DiscussRelationshipsController.destory_relationsip(@discuss, @quote, @program)
  end

  def self.create_relationship(src, quote, program)
    if src == nil || program == nil
      return
    end

    src.transaction do 
      src.update_attributes(:tv_program => program)     
      program.update_attributes(:discuss_count => program.discuss_count.next)
      if quote != nil
        quote.update_attributes(:tv_program => program)
        src.update_attributes(:quote_count => src.quote_count.next)      
        quote.update_attributes(:discuss_type => 1)
        quote.update_attributes(:src_id => src.id)
        DiscussRelationship.create(:src => src, :quote => quote, :time => Time.now)
      end
      src.save
    end
  end

  def self.destory_relationship(src, quote, program)
    if src == nil || program == nil
      return
    end

    src.transaction do
      src.update_attributes(:tv_program => nil)
      program.update_attributes(:discuss_count => (program.discuss_count-1) ) 
      if quote != nil
        quote.update_attributes(:tv_program => nil)
        src.update_attributes(:quote_count => (src.quote_count-1) )
        quote.update_attributes(:discuss_type => 0)
        quote.update_attributes(:src_id => nil)
        DiscussRelationship.destory(:src => src, :quote => quote)
      end
    end
  end

end
