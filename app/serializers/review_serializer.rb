class ReviewSerializer < ActiveModel::Serializer
  attributes :description, :id

  belongs_to :doctor
end
