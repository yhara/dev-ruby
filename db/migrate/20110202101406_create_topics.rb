class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.integer :post_id
      t.string :subject
      t.datetime :last_update
    end

    Post.roots.each do |root|
      Topic.create(
        post_id: root.id,
        subject: root.translated_subject,
        last_update: ([root] + root.descendants).sort_by(&:time).last.time
      ) or raise "failed to save!"
    end
  end

  def self.down
    drop_table :topics
  end
end
