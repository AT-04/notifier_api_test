# Delete channel
After('@delete_channel') do
  endpoint = "/channels/#{$id_hash['channels_id']}"
  request = ApiRequest.new(endpoint)
  request.method = 'DELETE'
  RequestManager.execute_request(request)
end

# Delete templates
After('@delete_templates') do
  endpoint = "/templates/#{$id_hash['templates_id']}"
  request = ApiRequest.new(endpoint)
  request.method = 'DELETE'
  RequestManager.execute_request(request)
end
