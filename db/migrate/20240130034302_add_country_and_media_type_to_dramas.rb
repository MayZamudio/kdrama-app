class AddCountryAndMediaTypeToDramas < ActiveRecord::Migration[7.0]
  def change
    add_column :dramas, :country, :string
    add_column :dramas, :media_type, :string
  end
end
