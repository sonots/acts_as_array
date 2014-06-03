class CreateMails < ActiveRecord::Migration
  def self.up
    create_table :mails do |t|
      t.string :name
      t.references :user
    end
    add_index :mails, :name, :unique => true
  end
 
  def self.down
    drop_table :mails
  end
end

