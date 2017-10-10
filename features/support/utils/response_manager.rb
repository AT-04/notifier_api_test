# Manage the conversion of hashes and string to json
module ResponseManager
  def self.parse_file(filename)
    base_path = File.dirname(__FILE__)
    path = "#{base_path}/templates/#{filename}.json"
    file = File.read(path)
    @template = JSON.parse(file)
    @copy = @template.is_a?(Hash) ? Hash[@template] : [].replace(@template)
  end

  def self.replace_elements_in_collection(collection)
    if @template.is_a?(Hash)
      @template.each_key do |key|
        @copy[key] = collection[key] if !(@template[key].eql? collection[key]) && (collection.key? key)
      end
    else
      @template.first.each_key do |key|
        @copy.first[key] = collection[key] if !(@template.first[key].eql? collection[key]) && (collection.key? key)
      end
    end
    @copy
  end

  def self.diff_elements_in_collection(collection)
    if @copy.is_a?(Hash)
      collection.delete_if { |key| !(@copy[key].eql? @template[key]) }
    else
      collection.delete_if { |key| !(@copy.first[key].eql? @template.first[key]) }
    end
  end

  def self.build_response(filename, request, expected, response)
    parse_file(filename)
    replace_elements_in_collection(JSON.parse(request))
    replace_elements_in_collection(JSON.parse(expected))
    if @copy.is_a?(Hash)
      replace_elements_in_collection(diff_elements_in_collection(JSON.parse(response)))
    else
      replace_elements_in_collection(diff_elements_in_collection(JSON.parse(response).first))
    end
    @copy
  end

  def self.contains_json(expected, response)
    expected = JSON.parse(expected)
    response = JSON.parse(response)
    response.each do |key|
      return true if key == expected.first
    end
    false
  end
end
