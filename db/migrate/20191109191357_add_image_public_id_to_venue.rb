class AddImagePublicIdToVenue < ActiveRecord::Migration[6.0]
  def change
    add_column :venues, :image_public_id, :string
  end
end
