class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.integer :user_id
    end

    User.all.each do |u|
      Account.create!(provider: u.provider,
                      uid: u.uid,
                      name: u.name,
                      user_id: u.id
                     )
    end

    [:provider, :uid].each do |column|
      remove_column :users, column
    end
  end

  def self.down
    drop_table :accounts
  end
end
