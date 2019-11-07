class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :full_name, :venues

  def venues
    self.object.venues.map{|v| v.id}
  end
end
