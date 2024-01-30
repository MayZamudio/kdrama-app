class AddActorNameToDramas < ActiveRecord::Migration[7.0]
  def change
    add_column :dramas, :actor_name, :string
  end
end
