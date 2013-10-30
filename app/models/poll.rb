require 'resolv'
class Poll < ActiveRecord::Base
  has_many :answers
  validates_presence_of :question
  validates :ip, :presence => true, :format => { :with => Resolv::IPv4::Regex }
  
end
