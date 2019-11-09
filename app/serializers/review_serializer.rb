class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :content, :rating, :user_id, :venue_id, :users_name, :created_at, :updated_at

  def users_name
    self.object.user.full_name
  end
end
