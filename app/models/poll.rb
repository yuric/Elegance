require 'resolv'
class Poll < ActiveRecord::Base
  has_many :answers
  validates_presence_of :question
  validates :ip, :presence => true, :format => { :with => Resolv::IPv4::Regex }
  
  def can_edit_poll?
    may_edit = false
    self.answers.each do |a|
      if a.votes.count > 0
        may_edit = true
      end
    end
    may_edit
  end
  
end
