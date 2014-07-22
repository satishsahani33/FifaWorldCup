class AddFeedIdToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :feed_id, :integer
  end
end
