class AddAncestryToMails < ActiveRecord::Migration
  def self.up
    add_column :mails, :ancestry, :string
    add_index :mails, :ancestry
  end

  def self.down
    remove_column :mails, :ancestry
    remove_index :mails, :ancestry
  end
end
