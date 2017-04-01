class Doctor < ActiveRecord::Base
  has_many :reviews

  validates :name, presence: true
  validates_uniqueness_of :name

  
end
