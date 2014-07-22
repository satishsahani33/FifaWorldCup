class FeedbacksController < ApplicationController

	def index
		@feedbacks=Feedback.order("created_at DESC")
	end

	def create
		if !Feedback.where("user_id=? and feed_id=?", params[:feedback][:user_id],params[:feedback][:feed_id]).present?
			@feedback=Feedback.new(params[:feedback])
			if @feedback.save
				flash[:notice]="your answer has been saved"
				redirect_to(:controller=>'feedbacks', :action=>'reply',:id=>params[:feedback][:feed_id])
			else
				flash[:notice]="Error Occured while saving your answer"
				redirect_to(:controller=>'feedbacks',:action=>'index')
			end
		else
			flash[:notice]="You have already answered this question"
			redirect_to(:controller=>'feedbacks',:action=>'reply', :id=>params[:feedback][:feed_id])
		end
	end

	def reply
		@feed=Feedback.find_by_id(params[:id])
		@user=User.find_by_id(@feed.user_id)
		@replies=Feedback.find_all_by_feed_id(params[:id])
	end

	def replies
		@feed=Feedback.find_by_id(params[:id])
		@user=User.find_by_id(@feed.user_id)
	end
	def create_question
		@feedback=Feedback.new(params[:feedback])
		if @feedback.save
			flash[:notice]="your question has been accepted"
			redirect_to(:controller=>'feedbacks', :action=>'index')
		else
			flash[:notice]="Error Occured while saving your feedback"
			redirect_to(:controller=>'feedbacks',:action=>'index')
		end
	end
end
