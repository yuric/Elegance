class Answer < ActiveRecord::Base
  belongs_to :poll
  has_many :votes
  validates_presence_of :content
  
end
