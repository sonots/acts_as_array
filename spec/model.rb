require 'active_record'
require 'acts_as_array'

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

class Mail < ActiveRecord::Base
  belongs_to :user
end

class Phone < ActiveRecord::Base
  belongs_to :user
end

class User < ActiveRecord::Base
  include ActsAsArray
  has_many :mails
  has_many :phones
  acts_as_array :mails => {:field => :name}, :phones => {:field => :name}
end
