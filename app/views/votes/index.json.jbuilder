json.array!(@votes) do |vote|
  json.extract! vote, :ip, :browser, :latitude, :longitude, :answer_id
  json.url vote_url(vote, format: :json)
end
