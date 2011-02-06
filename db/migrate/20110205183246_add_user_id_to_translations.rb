class AddUserIdToTranslations < ActiveRecord::Migration
  def self.up
    add_column :translations, :user_id, :integer
  end

  def self.down
    remove_column :translations, :user_id
  end
end
