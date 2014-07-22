class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
    	t.date :date
    	t.string :team_a
    	t.string :team_b
    	t.integer :score_a
    	t.integer :score_b
    end
  end
end
