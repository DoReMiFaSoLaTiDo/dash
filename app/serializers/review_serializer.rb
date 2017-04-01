class ReviewSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :doctor
end
