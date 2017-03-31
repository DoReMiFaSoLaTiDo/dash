class Review < ActiveRecord::Base
  belongs_to :doctor

  validates :description, presence: true
end
