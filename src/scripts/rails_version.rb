#!/usr/bin/env ruby
require "bundler"

ENV["BUNDLE_GEMFILE"] = "Gemfile"

# Force loading of the definition of the gemfile and what the locked gems are
Bundler.definition
Bundler.locked_gems
current_rails_version = Bundler.locked_gems.specs.find { _1.name == "rails"  }.version
expected_match = ENV.fetch("EXPECTED_RAILS_VERSION")
dependency = Gem::Dependency.new("rails", Gem::Requirement.new([expected_match]), :runtime)
if dependency.match?("rails", current_rails_version)
  puts "Gemfile.lock Rails version matches the expected rails version"
else
  puts "Yikes! found rails version [#{current_rails_version}]. Expected #{expected_match}. Something went wrong. Exiting"
  exit(1)
end

