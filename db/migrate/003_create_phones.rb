class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.string :name
      t.references :user
    end
  end
 
  def self.down
    drop_table :phones
  end
end

