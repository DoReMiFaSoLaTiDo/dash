class Doctor < ActiveRecord::Base
  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    "#{self.title} #{self.first_name} #{self.last_name}"
  end
end
