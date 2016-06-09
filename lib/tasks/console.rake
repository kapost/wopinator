desc 'Open IRB console for gem development environment'
task :console do
  require 'irb'
  require 'wopinator'
  ARGV.clear
  IRB.start
end
