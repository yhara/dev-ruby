class CreateMails < ActiveRecord::Migration
  def self.up
    create_table :mails do |t|
      t.integer :number, :null => false
      t.string :subject, :null => false
      t.string :from, :null => false
      t.datetime :time, :null => false
      t.integer :in_reply_to, :null => true
      t.text :body, :null => false
    end
    add_index :mails, :number
  end

  def self.down
    drop_table :mails
  end
end
