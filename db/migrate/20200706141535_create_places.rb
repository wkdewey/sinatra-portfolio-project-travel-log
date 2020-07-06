class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :country
      t.string :city

      t.timestamps null: false
    end
  end
end
