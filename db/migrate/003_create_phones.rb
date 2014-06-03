class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.string :name
      t.references :user
    end
    add_index :phones, :name, :unique => true
  end
 
  def self.down
    drop_table :phones
  end
end

