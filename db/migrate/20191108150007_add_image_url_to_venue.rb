class AddImageUrlToVenue < ActiveRecord::Migration[6.0]
  def change
    add_column :venues, :image_url, :string
  end
end
