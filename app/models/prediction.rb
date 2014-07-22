class Prediction < ActiveRecord::Base
  attr_accessible :match_id, :user_id, :predict_score_a, :predict_score_b, :bet
  belongs_to :user
  belongs_to :match
  accepts_nested_attributes_for :match

  validates :predict_score_a, :numericality=>{:only_integer=>true} 
  validates :predict_score_b, :numericality=>{:only_integer=>true}
  validates_format_of :predict_score_a, :with => /^\d+$/, :message => 'Accepts only numbers'
  validates_format_of :predict_score_b, :with => /^\d+$/, :message => 'Accepts only numbers'
end
