module PollsHelper
  def calculate_votes(poll)
    votes = 0
    poll.answers.each_with_index do |answer,i|
      votes += answer.votes.count
    end
    if votes == 0
      "0 votes"
    elsif votes == 1
      "1 vote"
    else
      "#{votes} votes"
    end
    
  end
end
