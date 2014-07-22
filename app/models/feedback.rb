class Feedback < ActiveRecord::Base
  attr_accessible :user_id, :feedback,:feed_id
  belongs_to :user
end
