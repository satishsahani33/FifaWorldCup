class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.references :match
      t.references :user
      t.integer :predict_score_a
      t.integer :predict_score_b
      t.timestamps
    end
  end
end
