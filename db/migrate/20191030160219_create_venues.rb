class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :description
      t.float :latitude
      t.float :longitude
      t.string :place_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
