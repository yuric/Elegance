require 'test_helper'

class PollTest < ActiveSupport::TestCase
  setup do
    @p = polls(:full)
  end
  
  test "invalid with empty question" do
    @p.question = nil
    assert !@p.valid?, "Question is not being checked for empty"
  end
  test "invalid with too short of a question" do
    #
  end
  test "invalid if ip is blank" do
    @p.ip = nil
    @p.valid?
    assert_match /can't be blank/, @p.errors[:ip].join, "=> blank ip error not found."
  end
  
  test "invalid ip with regex" do 
    @p.ip = "127.1.poo"
    refute_match Resolv::IPv4::Regex, @p.ip, "IP formatting not properly validated"
  end
  

end
