class DoctorSerializer < ActiveModel::Serializer
  attributes :name, :id

  has_many :reviews

end
