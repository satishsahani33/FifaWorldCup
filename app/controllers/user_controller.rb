class UserController < ApplicationController

  before_filter :require_login, :except => [:index, :signin ,:signup, :login, :create]

  def index
  	@user=User.all
    @ScoreBoard=[]
    @user.each do |user| 
      @ScoreBoard<<[user.username.downcase, User.getUserScore(user.id)]
    end
    @ScoreBoard=@ScoreBoard.sort_by{|k,v| [-v,k]}
  end

  def score_board
    @user=User.all
    @ScoreBoard=[]
    @user.each do |user| 
      @ScoreBoard<<[user.username.downcase, User.getUserScore(user.id)]
    end
    @ScoreBoard=@ScoreBoard.sort_by{|k,v| [-v,k]}
  end

  def signup
  	@user=User.new
  end

  def virtual_attribute
  @virtual_attribute
end

#setter
def virtual_attribute=(value)
  @virtual_attribute = value
end
#
# 
#create action is used to create NEW USER
  def create
    if params[:user][:username].present? && params[:user][:password].present? 
      if (params[:user][:password]==params[:user][:confirm_password]) && !User.find_by_username(params[:user][:username]).present? && User.check_username(params[:user][:username])
        if User.new(:username=>params[:user][:username],:password=>params[:user][:password]).valid?
        	@user=User.new(params[:user])
        	if @user.save
            flash[:notice]="Click Sigin!!"
            redirect_to(:controller=>'user',:action=>'index')
        	else
        		flash[:notice]='ERROR OCCURED'
            redirect_to(:controller=>'user',:action=>'signup')
        	end
        else
          flash[:notice]="Username and Password must each be 4 characters long"
          redirect_to(:controller=>'user',:action=>'signup')
        end
      else
        if (params[:user][:password]!=params[:user][:confirm_password])
          flash[:notice]="Your Password Doesn't Match"
          redirect_to(:controller=>'user', :action=>'signup')
        elsif User.find_by_username(params[:user][:username]).present?
          flash[:notice]="Username Already Exists"
          redirect_to(:controller=>'user', :action=>'signup')
        elsif !User.check_username(params[:user][:username])
          flash[:notice]="Invalid username "
          redirect_to(:controller=>'user', :action=>'signup')
        end
      end
    else
      flash[:notice]="Username and Password must be entered"
      redirect_to(:controller=>'user',:action=>'signup')
    end
  end

  def signin
   @user=User.new
  end
#
#
#login action is used to log in to the accouct using username and password
#If condition is true then users id is set as session and redirects to welcome page
  def login
    if params[:user][:username].present? && params[:user][:password].present?
    	@user=User.find_by_username(params[:user][:username])
    	if @user.present?
        if @user.username.downcase==params[:user][:username].downcase && @user.password==params[:user][:password]
      		#render(:text=>@user.username)
          session[:user] = @user.id
      		redirect_to(:action=>"welcome")
        else
          flash[:notice]='Invalid Username or Password.'
          redirect_to(:controller=>'user', :action=>'signin')     
        end
    	else
    		flash[:notice]="#{params[:user][:username]} is Not Registered plz signup to login"
        redirect_to(:controller=>'user', :action=>'signin')  
    	end
    else
      flash[:notice]="Username and Password must be entered"
      redirect_to(:controller=>'user',:action=>'signin')
    end
  end
#
#
#displays the welcome page of a user  
  def welcome
  	@user=User.find_by_id(session[:user])
    @score=User.getUserScore(@user.id)
    # @match=
  #   Match.find_by_sql("SELECT matches.id AS match_id, matches.team_a, matches.team_b, 
  #     p.predict_score_a, p.predict_score_b 
  #     FROM `matches` INNER JOIN predictions p ON p.match_id = matches.id 
  #     WHERE p.user_id = '2'")
  end

#
#Calculates the Score obtained by the user and returns the value 
  def getUserScore(user_id)
    @user=User.find_by_id(user_id)
    user_score=0
     @user.predictions.each do |prediction|
        @match=Match.find(prediction.match_id)
          if (prediction.predict_score_a==@match.score_a) && (prediction.predict_score_b==@match.score_b)
            user_score+=4
          elsif (prediction.predict_score_a==@match.score_a) || (prediction.predict_score_b==@match.score_b)
            user_score+=1 
          #elsif (prediction.predict_score_a==@match.score_a) && (prediction.predict_score_b!=@match.score_b)
           # user_score+=1
          end
      end
      return user_score
  end


  def list
    if(session[:user]==36)
      @users=User.all
    else
      redirect_to(:action=>'welcome')
    end
  end

  def edit
    @user=User.find_by_id(params[:id])
  end

  def update_user_role
    if(session[:user]==36)
      @user=User.find_by_id(params[:id])
      if @user.update_attributes(params[:update])
        redirect_to(:action=>'list')
      else
        Render(:text=>"ERROR OCCURED")
      end
    else
      redirect_to(:action=>'welcome')
    end
  end

  def delete
    if User.find_by_id(params[:id]).destroy
      redirect_to(:action=>'list')
    end
  end
#
#
#logout clears the session and redirects user to users index page
  def logout
    session.clear
    flash[:notice] = "You have successfully logged out."
    redirect_to(:action=>'index')
  end

  private
  def require_login
    unless session[:user]
      redirect_to(:controller=>'user', :action=>'index')
    end
  end
end
