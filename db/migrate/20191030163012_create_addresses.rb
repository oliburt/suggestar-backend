class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :venue, null: false, foreign_key: true
      t.string :address_identifier
      t.integer :street_number
      t.string :street_name
      t.string :address_type
      t.string :flat_number
      t.string :governing_district
      t.string :minor_muncipality
      t.string :major_municipality
      t.string :post_code
      t.string :country

      t.timestamps
    end
  end
end
