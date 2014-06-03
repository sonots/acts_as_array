require 'active_record'

# create_table :users do |t|
#   t.string :name
# end
# create_table :mails do |t|
#   t.string :name
#   t.references :user
# end
# create_table :phones do |t|
#   t.string :name
#   t.references :user
# end

class User < ActiveRecord::Base
  include ActsAsArray
  has_many :mails
  has_many :phones
end

class Mail < ActiveRecord::Base
  belongs_to :user
end

class Phone < ActiveRecord::Base
  belongs_to :user
end
