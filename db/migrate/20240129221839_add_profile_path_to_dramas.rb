class AddProfilePathToDramas < ActiveRecord::Migration[7.0]
  def change
    add_column :dramas, :profile_path, :string
  end
end
