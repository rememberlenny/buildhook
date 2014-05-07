json.array!(@services) do |service|
  json.extract! service, :id, :name, :action
  json.url service_url(service, format: :json)
end
