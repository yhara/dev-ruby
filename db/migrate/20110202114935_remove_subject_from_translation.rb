class RemoveSubjectFromTranslation < ActiveRecord::Migration
  def self.up
    remove_column :translations, :subject 
  end

  def self.down
    add_column :translations, :subject, :string
  end
end
