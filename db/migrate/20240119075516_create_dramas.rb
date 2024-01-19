class CreateDramas < ActiveRecord::Migration[7.0]
  def change
    create_table :dramas do |t|
      t.string :title
      t.text :overview
      t.string :air_date
      t.integer :rating
      t.string :backdrop
      t.string :poster

      t.timestamps
    end
  end
end
