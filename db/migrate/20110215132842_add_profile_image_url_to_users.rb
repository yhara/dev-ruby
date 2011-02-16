class AddProfileImageUrlToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :profile_image_url, :string
  end

  def self.down
    remove_column :users, :profile_image_url
  end
end
