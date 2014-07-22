class User < ActiveRecord::Base
  attr_accessible :username, :password, :admin, :confirm_password
  has_many :predictions 
  has_many :feedbacks
  has_many :matches, through: :predictions
  # :through => :customer_customer_types

  validates :username,:presence=>true,:uniqueness=>true,:length=>{:maximum=>20, :minimum=>3}
  validates :password,:presence=>true,:length=>{:maximum=>50,:minimum=>4}


  def confirm_password
    @confirm_password
  end

  def confirm_password=(value)
    @confirm_password = value
  end

    def self.adminUser(user_id)
        @user=User.find_by_id(user_id)
        if @user.admin
          return true
        else
          return false
        end
    end

  	def self.getUserScore(user_id)
   	 	@user=User.find_by_id(user_id)
    	user_score=0
     	@user.predictions.each do |prediction|
        @match=Match.find_by_id(prediction.match_id)
        if @match.present?
          if (prediction.predict_score_a==@match.score_a) && (prediction.predict_score_b==@match.score_b)
            user_score+=3
          elsif (prediction.predict_score_a==@match.score_a) || (prediction.predict_score_b==@match.score_b)
            user_score+=1 
          #elsif (prediction.predict_score_a==@match.score_a) && (prediction.predict_score_b!=@match.score_b)
           # user_score+=1
          end
      	end
      end
      return user_score
  	end

    def self.check_username(username)
       custom_users=["ADMIN","Abhisheks","Abhishekt","Anild","Anujb","Arnishas","BalMukunds","Bhuwanp","Bijayk","Binays","Bipins","Bishals",
        "Biswast","Chandant","Deepaks","Dharmak","Dhums","Dipus","Dixat","Gauravm","Gautams","Harik","Irinaj","Ishang","Ishworb",
        "Jasmeenb","Junas","Jyotip","Keshabp","Kubera","Madava","Mohanaa","Mohitm","Nabinj","Narayanc","Naresht","Nimmis","Nishab",
        "Nripendrap","Pabitrab","Payalc","Pradeepm","Prajeenas","Rabis","Rabindras","Rajand","Rajanm","Rams","Rameshs","Ranjans",
        "Ranjeetp","Razm","Ritenh","Riteshd","Riwajr","Rojinam","Saguns","Samits","Sangitg","Santoshk","Saraswatip","Satishs",
        "Shaileshh","Soyuzu","Subodhp","Sudeepk","Sudhirm","Sujant","Sumana","Sumank","Sunilk","Sushilp","Swetap","Upendras","Vikramg"]
       result=false
      custom_users.each do |custom_user|
        if custom_user.downcase==username.downcase
          result=true
        end
      end
      result
    end
end
