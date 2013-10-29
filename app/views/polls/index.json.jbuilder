json.array!(@polls) do |poll|
  json.extract! poll, :voter_id, :question
  json.url poll_url(poll, format: :json)
end
