class AddAddressToVenue < ActiveRecord::Migration[6.0]
  def change
    add_column :venues, :address, :string
  end
end
