class CreateMails < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :number, :null => false
      t.string :subject, :null => false
      t.string :from, :null => false
      t.datetime :time, :null => false
      t.text :body, :null => false
      t.string :ancestry
    end
    add_index :posts, :number
    add_index :posts, :ancestry
  end

  def self.down
    drop_table :posts
  end
end
