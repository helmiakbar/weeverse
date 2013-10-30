json.array!(@ideas) do |idea|
  json.extract! idea, :title, :description, :image
  json.url idea_url(idea, format: :json)
end
