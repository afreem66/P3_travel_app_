class AddUserMarkerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_marker, :string
  end
end
