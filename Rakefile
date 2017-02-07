require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = "--tag ~feature"
end

RSpec::Core::RakeTask.new(:feature) do |task|
  task.rspec_opts = "--tag feature"
end