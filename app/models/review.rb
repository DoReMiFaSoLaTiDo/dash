class Review < ActiveRecord::Base
  belongs_to :doctor

  validates :description, presence: true
  validates :ratings, inclusion: { in: 1..5 }
end
