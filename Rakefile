require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'report_builder'

desc 'This task built the json report '
task :rjson, [:tag] do |_t, args|
  sh "cucumber -t @#{args.tag} -f json -o reports/#{args.tag}/report.json"
end

desc 'This task built the html report '
task :rhtml, [:tag] do |_t, args|
  ReportBuilder.configure do |config|
    config.json_path = "reports/#{args.tag}/"
    config.report_path = "reports/#{args.tag}/report"
    config.report_types = [:html]
    config.report_title = 'Notifier Report Results'
    config.include_images = false
  end
  ReportBuilder.build_report
end
