require 'resolv'
class Poll < ActiveRecord::Base
  has_many :answers
  validates_presence_of :question
  validates :ip, :presence => true, :format => { :with => Resolv::IPv4::Regex }
  
  def poll_has_votes?
    voted = false
    self.answers.each do |a|
      if a.votes.count > 0
        voted = true
      end
    end
    voted
  end
  def i_own?(rip)
    self.ip == rip ? true : false
  end
  
end
