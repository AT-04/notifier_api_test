require 'json'
require 'json_spec/cucumber'
require 'pathname'
require 'rest-client'
require 'yaml'
$id_hash = {}
def find_config_file(filename)
  root = Pathname.pwd
  until root.root?
    root.find do |path|
      return path.to_s if path.file? && path.basename.to_s == filename
    end
    root = root.parent
  end
  raise 'Configuration file '
end

def load_app_config_file(filename)
  config_file = find_config_file(filename)
  config = YAML.load_file(config_file)
  $app_context = config['app']['rootPath']
  config
end

AfterConfiguration do
  configuration = load_app_config_file('env.yml')
  $app_host = configuration['app']['host']
  $app_port = configuration['app']['port']
  $app_root = configuration['app']['rootPath']
  $app_max_wait_time = configuration['app']['maxWaitTime']
end

def last_json
  # Just for initialize
end
