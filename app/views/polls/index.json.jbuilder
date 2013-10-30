json.array!(@polls) do |poll|
  json.extract! poll, :question
  json.url poll_url(poll, format: :json)
end
