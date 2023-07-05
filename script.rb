require 'json'
require 'logger'
require 'bundler'
Bundler.require

logger = Logger.new('log/logfile.log')

listener = Listen.to(ENV['DIR_PATH']) do |_modified, added, _removed|
  unless added.empty?
    added.each do |path|
      control_plan = JSON.parse(File.read(path), object_class: OpenStruct).test
      logger.info("ID: #{control_plan.id} CODE: #{control_plan.pianoControllo} EDITION: #{control_plan.versionePiano} COUNT: #{control_plan.dettagli.item.count}")
    end
  end
end

listener.start # not blocking
sleep

