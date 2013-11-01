class Answer < ActiveRecord::Base
  belongs_to :poll
  has_many :votes
  validates_presence_of :content
  validates_length_of :content, :minimum => 1, :maximum => 255, :allow_blank => false
  
  
end
