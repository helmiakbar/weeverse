json.array!(@projects) do |project|
  json.extract! project, :title, :description, :address
  json.url project_url(project, format: :json)
end
