class MatchController < ApplicationController

  def index
      redirect_to(:action=>'list')
  end

  def list
      @date=Date.today
      @matches=Match.all
      #where("matches.date >= ?", @date).order("date ASC")
  end

  def new
    @match=Match.new
    render('create')
  end

  def create
  	@date=Match.new(params[:match])
  	if @date.save
      flash[:notice]="Match Has Been Created"
      redirect_to(:action=>'list')
  		#render(:text=>"SUCCESSFULL")
  	else
  		flash[:notice]="Error Occured While Creating Match"
      redirect_to(:action=>'list')
  	end
  end

  def edit
    @match=Match.find(params[:id])
    render('edit')
  end

  def update
    @match=Match.find(params[:id])
    if @match.update_attributes(params[:match])
        flash[:notice]="Match #{@match.team_a} Vs #{@match.team_b}Has Been Updated"
        redirect_to(:action=>'list')
        #render(:text=>"SUCCESSFULL")
    else
      flash[:notice]="Error Occured While Updating Match"
      redirect_to(:action=>'list')
    end
  end

  def delete
    @match=Match.find(params[:id])
    if @match.destroy
      flash[:notice]="Match #{@match.team_a} Vs #{@match.team_b} has been Deleted"
      redirect_to(:action=>'list')
    else
     flash[:notice]="Error Occured While Deleting Match"
     redirect_to(:action=>'list')
    end
  end
end
