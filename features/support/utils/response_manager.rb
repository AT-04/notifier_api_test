# Manage the conversion of hashes and string to json
module ResponseManager
  def self.parse_file(filename)
    base_path = File.dirname(__FILE__)
    path = "#{base_path}/templates/#{filename}.json"
    file = File.read(path)
    @template = JSON.parse(file)
    @copy = @template.is_a?(Hash) ? Hash[@template] : [].replace(@template)
  end

  def self.replace_in_hash(hash)
    @template.each_key do |key|
      if !(@template[key].eql? hash[key]) && (hash.key? key)
        @copy[key] = hash[key]
      end
    end
    @copy
  end

  def self.diff_hash(hash)
    hash.delete_if {|key| !(@copy[key].eql? @template[key])}
  end

  def self.build_response(filename, request, expected, response)
    parse_file(filename)
    request = JSON.parse(request)
    expected = JSON.parse(expected)
    response = JSON.parse(response)
    @copy.is_a?(Hash) ? build_with_hash(request, expected, response) : build_with_array(request, expected, response)
  end

  def self.build_with_hash(request, expected, response)
    puts replace_in_hash(request)
    puts replace_in_hash(expected)
    replace_in_hash(diff_hash(response))
  end

  def self.build_with_array(request, expected, response)
    replace_in_array(request)
    replace_in_array(expected)
    replace_in_array(diff_array(response[0]))
  end

  def self.replace_in_array(array)
    @template[0].each_key do |key|
      if !(@template[0][key].eql? array[key]) && (array.key? key)
        @copy[0][key] = array[key]
      end
    end
    @copy
  end

  def self.diff_array(hash)
    hash.delete_if {|key| !(@copy[0][key].eql? @template[0][key])}
  end

  def self.build_error_response(filename, expected, response)
    parse_file(filename)
    expected = JSON.parse(expected)
    response = JSON.parse(response)
    replace_in_hash(expected)
    replace_in_hash(diff_hash(response))
  end
end
