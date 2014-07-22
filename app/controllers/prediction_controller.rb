class PredictionController < ApplicationController

  before_filter :require_login
  def index
    @user=User.find_by_id(session[:user])
    @date=DateTime.now
  	@matches=Match.select("matches.id,matches.date,matches.day, matches.team_a, matches.team_b, matches.score_a,matches.score_b, p.predict_score_a, p.predict_score_b,p.bet").
    joins("LEFT JOIN predictions p ON p.match_id = matches.id AND p.user_id = #{session[:user]}")

    # bets=(Prediction.where("bet=? AND match_id=?",true,match.id).length.to_s)+" "+"BETS"
    # predictions=(Prediction.where("match_id=?",match.id).length.to_s)+" "+"PREDICTIONS"
    # @counts= bets + predictions
    #where("matches.date >?", @date).order("date ASC")
    @predict=Prediction.new
  end

  def create
    (params[:predict]).each do |prediction|
      @match=Match.find_by_id(prediction[:match_id])
      @predict_attr={:match_id=>prediction[:match_id],
                          :user_id=>session[:user],
                          :predict_score_a=>prediction[:predict_score_a],
                          :predict_score_b=>prediction[:predict_score_b],
                          :bet=>prediction[:bet]
                        }       
      if @match && @match.date<=DateTime.now
         flash[:notice]="Match Has Already Taken Place"     
      else
        if prediction[:predict_score_a].present? && prediction[:predict_score_b].present?
          if Prediction.find_by_match_id_and_user_id(prediction[:match_id],session[:user]).present?
            @prediction=Prediction.find_by_match_id_and_user_id(prediction[:match_id],session[:user])
            if @prediction.update_attributes(@predict_attr)
              flash[:notice]="Your Prediction Has Been Saved"
            else
              flash[:notice]="Error Occured While Updating your Prediction."
            end
          else
            @predict=Prediction.new(@predict_attr)
            if @predict.save
             flash[:notice]="Your Prediction Has Been Saved"
            else
              flash[:notice]="Error Occured While Saving your Prediction."
            end
          end
        end
      end
    end  
    redirect_to(:controller=>'user',:action=>'welcome')
  end


  def list
    # @predictions=Prediction.where(:match_id=>params[:id]).order("bet DESC,rand()")
    @predictions=User.find_by_sql("select users.username, predictions.match_id,predictions.predict_score_a, predictions.predict_score_b,predictions.bet,predictions.user_id from users,predictions WHERE predictions.user_id = users.id AND predictions.match_id=#{params[:id]} ORDER BY predictions.bet DESC,users.username ASC")
  end

  def place_bet
    @prediction=Prediction.find_by_id(params[:id])
    @match=Match.find_by_id(@prediction.match_id)
    if @prediction.update_attributes(:bet=>true) and @match.date>DateTime.now
      flash[:notice]="Bet For Match #{@match.team_a} vs #{@match.team_b} Has Been Placed"
      redirect_to(:controller=>'user', :action=>'welcome')
    else
      flash[:notice]="Bet is invalid"   
      #render(:text=>"ERROR OCCURED")
    end
  end

  def remove_bet
     @prediction=Prediction.find_by_id(params[:id])
     @match=Match.find_by_id(@prediction.match_id)
    if @prediction.update_attributes(:bet=>false) and @match.date>DateTime.now
      #render(:text=>"Bet removed successfully")
      flash[:notice]="Bet For #{@match.team_a} vs #{@match.team_b} Has Been Removed"
      redirect_to(:controller=>'user', :action=>'welcome')
    else
      flash[:notice]="Bet is invalid"
      #render(:text=>"ERROR OCCURED")
    end
  end

   private
  def require_login
    unless session[:user]
      redirect_to(:controller=>'user', :action=>'signin')
    end
  end
end
