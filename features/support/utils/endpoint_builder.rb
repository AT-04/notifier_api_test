# This module build endpoint with id and params
module EndpointBuilder
  def self.builder(endpoint)
    endpoint.gsub('$id', $id_hash[$identifier_name].to_s)
  end

  def self.param(endpoint, param)
    point = builder endpoint
    param.each_with_index do |value, index|
      params = "#{value[0].gsub(' ', '%20')}=#{value[1].gsub(' ', '%20')}"
      params = params.gsub('#', '%23').to_s
      point = index.to_i.zero? ? "#{point}?#{params}" : "#{point}&#{params}"
    end
    point
  end
end
