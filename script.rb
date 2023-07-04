require 'json'
require 'logger'
require 'bundler'
Bundler.require

logger = Logger.new('log/logfile.log')

listener = Listen.to(ENV['DIR_PATH']) do |_modified, added, _removed|
  unless added.empty?
    added.each do |path|
      json_file = File.read(path)
      control_plan = JSON.parse(json_file, object_class: OpenStruct).test
      logger.info("Added file ID: #{control_plan.id} CODE: #{control_plan.pianoControllo} EDITION: #{control_plan.versionePiano} FILE LENGTH: #{json_file.each_line.count}")
    end
  end
end

listener.start # not blocking
sleep

