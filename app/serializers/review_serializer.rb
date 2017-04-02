class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :doctor_id, :description

  belongs_to :doctor
end
