# Request Manager class.
module RequestManager
  def self.execute_request(api_request)
    RestClient::Request.execute(method: api_request.method,
                                url: api_request.url,
                                payload: api_request.body,
                                headers: api_request.header)
  rescue RestClient::ExceptionWithResponse => error
    error.response
  end
end
