class AddVenueToListing < ActiveRecord::Migration[6.0]
  def change
    add_reference :listings, :venue, null: false, foreign_key: true
  end
end
