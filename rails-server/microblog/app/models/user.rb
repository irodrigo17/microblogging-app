class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  has_many :messages

  validates :name,  :presence => true
  validates :email, :presence => true, 
  					:uniqueness => true,
  					:format => { 
  						:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, 
  						:message => "Must be a valid email address"}
  validates :password, :presence => true
end
