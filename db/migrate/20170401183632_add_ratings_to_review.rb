class AddRatingsToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :ratings, :integer, null: false, default: 1
    add_column :reviews, :reviewer, :string
  end
end
