require 'resolv'
class Poll < ActiveRecord::Base
  validates_presence_of :question
  validates :ip, :presence => true, :format => { :with => Resolv::IPv4::Regex }
  
end
