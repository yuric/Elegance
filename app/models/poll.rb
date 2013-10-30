require 'resolv'
class Poll < ActiveRecord::Base
  has_many :answers
  validates_presence_of :question
  validates :ip, :presence => true, :format => { :with => Resolv::IPv4::Regex }
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a['content'].blank? || a['id'] }, allow_destroy: true
  #validate :must_have_answers

  def must_have_answers
    if self.answers.empty?
      errors.add(:base, 'Must have at least 3 options/answers')
    elsif self.answers.count < 2
      errors.add(:base, "B: Must have at least 3 options/answers #{self.answers.count}")
    elsif self.answers.count > 5
      errors.add(:base, 'Must have no more than 5 options/answers')
    else
    end
  end
  
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
