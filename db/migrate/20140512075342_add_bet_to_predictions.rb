class AddBetToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :bet, :boolean, :default=>false
  end
end
