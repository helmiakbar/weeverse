json.array!(@socials) do |social|
  json.extract! social, 
  json.url social_url(social, format: :json)
end
