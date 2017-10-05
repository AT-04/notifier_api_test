Given(/^I make a '(\w+)' request to '(.+)' endpoint$/) do |method, endpoint|
  @request = ApiRequest.new(EnpointBuilder.builder(endpoint))
  @request.method = method
end

When(/^I execute the request to the endpoint$/) do
  @response = RequestManager.execute_request(@request)
  puts @response.code
  puts @response.body
end

Then(/^I expect a '(\d+)' status code$/) do |status_code_expected|
  expect(@response.code).to eql(status_code_expected.to_i)
end

And(/^I make a '(PUT|POST|GET)' request to '(.+)' with:$/) do |method, endpoint, param|
  @request = ApiRequest.new(EnpointBuilder.param(endpoint, param.raw))
  @request.method = method
end

Then(/^The response body is$/) do |expected_body|
  expect(JSON.parse(@response.body)).to eq JSON.parse(expected_body)
end

When(/^I set the body as:$/) do |body|
  puts body
  @body = body
  @request.body = body
end

When(/^I set the body with id:$/) do |body|
  body = body.gsub('$id', $id_hash[$identifier_name].to_s)
  @body = body
  @request.body = body
end

When(/^I save the '(\w+)' of '(channels|notification|templates)'$/) do |name, type|
  # $identifier_name = name
  $identifier_name = "#{type}_#{name}"
  $id_hash.store($identifier_name, JSON.parse(@response.body)[name])
end

Then(/^I build the response for "([^"]*)" with$/) do |template, json|
  @builded_hash = ResponseManager.build_response(template, @body, json, @response.body)
end

Then(/^The response body is the same as builded$/) do
  expect(@builded_hash.to_json).to eq @response.body
  puts @builded_hash.to_json
  puts @response.body
end

Then(/^I capture the response to the endpoint$/) do
  @stored_response = @response.body
end

Then(/^I expect (?:PUT|POST) response is the same as GET response$/) do
  expect(JSON.parse(@response.body)).to eq JSON.parse(@stored_response)
  expect(@response.body).to eq @stored_response
end

Then(/^I expect that the GET response it is empty$/) do
  expect(@response.body).to eq ''
end

And(/^I make a '(GET)' request to '(.+)' until the field '(.+)' at '(.+)' is '(.+)'$/) do |method, endpoint, field, params, value|
  $app_max_wait_time.times do
    sleep 1
    steps %{
        And I make a '#{method}' request to '#{endpoint}' endpoint
        And I execute the request to the endpoint
     }
    @result_expected = JSON.parse(@response.body)[field][params]
    break if @result_expected == value
  end
  expect(value).to eq @result_expected
end

And(/^I make a '(GET)' request to '(.+)' until that '(.+)' is '(.+)'$/) do |method, endpoint, params, value|
  endpoint = EnpointBuilder.builder(endpoint)
  $app_max_wait_time.times do
    steps %{
        And I make a '#{method}' request to '#{endpoint}' endpoint
        And I execute the request to the endpoint
     }
    if @response.empty? && value == JSON.parse(@response.body)[params]
      break
    end
    sleep 1
  end
end

Given(/^I create a Channel with the body as:$/) do |body|
  steps %{
         Given I make a 'POST' request to '/channels' endpoint
         When I set the body as:
         """
          #{body}
         """
         And I execute the request to the endpoint
         Then I expect a '200' status code
       }
end

Then(/^the response body contains:$/) do |json|
  expect(json).to be_json_eql(@response.body).excluding("timestamp")
  puts @response.body
  puts json
end

Then(/^the response body contains excluding '([^"]*)':$/) do |exclude, json|
  expect(json).to be_json_eql(@response.body).excluding(exclude)
  puts @response.body
  puts json
end
