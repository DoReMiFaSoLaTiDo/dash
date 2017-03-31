class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :description
      t.references :doctor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
