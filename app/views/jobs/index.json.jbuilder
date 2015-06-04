json.array!(@jobs) do |job|
  json.extract! job, :id, :title, :description, :source_language, :target_language, :deadline
  json.url job_url(job, format: :json)
end
