class CreateTranslationRequests < ActiveRecord::Migration
  def self.up
    create_table :translation_requests do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end

  def self.down
    drop_table :translation_requests
  end
end
