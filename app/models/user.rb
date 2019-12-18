class User < ApplicationRecord
  validates_presence_of :login, :token
  validates_uniqueness_of :login
end
