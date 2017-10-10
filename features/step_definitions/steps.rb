Given(/^I make a '(\w+)' request to '(.+)' endpoint$/) do |method, endpoint|
  @request = ApiRequest.new(EndpointBuilder.builder(endpoint))
  @request.method = method
end

When(/^I execute the request to the endpoint$/) do
  @response = RequestManager.execute_request(@request)
end

Then(/^I expect a '(\d+)' status code$/) do |status_code_expected|
  expect(@response.code).to eql(status_code_expected.to_i)
end

And(/^I make a '(PUT|POST|GET)' request to '(.+)' with:$/) do |method, endpoint, param|
  @request = ApiRequest.new(EndpointBuilder.param(endpoint, param.raw))
  @request.method = method
end

Then(/^The response body is$/) do |expected_body|
  expect(JSON.parse(@response.body)).to eq JSON.parse(expected_body)
end

When(/^I set the body as:$/) do |body|
  @body = body
  @request.body = body
end

When(/^I set the body with (?:\w+):$/) do |body|
  @body = BodyBuilder.builder(body)
  @request.body = BodyBuilder.builder(body)
  puts @body
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
  expect(@response.body).to eq @stored_response
  @response.body
  @stored_response
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

Given(/^I create a '(channel|template)' with status code '(\d+)' and body as:$/) do |type, status, body|
  steps %{
         Given I make a 'POST' request to '/#{type}s' endpoint
         When I set the body as:
         """
          #{body}
         """
         And I execute the request to the endpoint
         Then I expect a '#{status}' status code
       }
end

Then(/^the response body contains excluding '([^"]*)':$/) do |exclude, json|
  expect(json).to be_json_eql(@response.body).excluding(exclude)
  puts json
  puts @response.body
end

Then(/^excluding '([^"]*)' and '(.*)' the response body contains:$/) do |exclude1, exclude2, json|
  expect(json).to be_json_eql(@response.body).excluding(exclude1, exclude2)
  puts json
  puts @response.body
end

Then(/^I generate '(\w+)' letter (\d+) times and save for '(\w+)' field$/) do |letter, n, field|
  $id_hash.store(field, LongString.generator(letter, n))
end

Then(/^The response body should contain the builded response$/) do
  expect(ResponseManager.contains_json(@builded_hash.to_json, @response.body)).to be(true)
  puts @builded_hash.to_json
  puts @response.body
end
