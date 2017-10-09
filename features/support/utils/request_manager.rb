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

  def self.generator(l, n)
    cad = ''
    n.to_i.times do
      cad += l.to_s
    end
    cad
  end
end
