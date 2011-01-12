class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.integer :mail_id
      t.string :subject
      t.text :body
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :translations
  end
end
