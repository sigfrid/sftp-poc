require 'bundler'
Bundler.require




listener = Listen.to(ENV['DIR_PATH']) do |_modified, added, _removed|
  unless added.empty?
    added.each do |path|
      p File.read(path).each_line.count
    end
  end
end

listener.start # not blocking
sleep

