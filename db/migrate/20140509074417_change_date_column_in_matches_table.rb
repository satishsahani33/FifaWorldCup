class ChangeDateColumnInMatchesTable < ActiveRecord::Migration
  def change
  	change_column :matches, :date, :datetime
  end
end
