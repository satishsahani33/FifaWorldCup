class AddDayToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :day, :string
  end
end
