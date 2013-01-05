class Message < ActiveRecord::Base
  attr_accessible :text, :user
  belongs_to :user  

  validates :text, :presence => true
  validates :user, :presence => true
end
