class Match < ActiveRecord::Base
  attr_accessible :date, :team_a, :team_b, :score_a, :score_b, :day
  has_many :predictions, dependent: :destroy
  has_many :users, through: :predictions
  accepts_nested_attributes_for :predictions
end
