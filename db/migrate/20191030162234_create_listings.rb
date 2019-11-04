class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :description
      t.string :ticket_url
      t.string :age_restriction
      t.datetime :begin_datetime
      t.datetime :end_datetime
      t.string :title

      t.timestamps
    end
  end
end
