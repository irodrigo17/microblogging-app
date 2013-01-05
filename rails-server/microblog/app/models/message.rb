class Message < ActiveRecord::Base
  attr_accessible :text, :user
  belongs_to :user  
end
