# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{belly}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Wynne"]
  s.date = %q{2010-07-19}
  s.default_executable = %q{belly}
  s.description = %q{Client app for the incredible new belly web service, coming soon.}
  s.email = %q{matt@mattwynne.net}
  s.executables = ["belly"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc",
     "TODO"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "TODO",
     "VERSION",
     "belly.gemspec",
     "bin/belly",
     "features/publish_scenario_results.feature",
     "features/step_definitions/belly_steps.rb",
     "features/step_definitions/cucumber_steps.rb",
     "features/support/env.rb",
     "features/support/fake_hub.rb",
     "lib/belly.rb",
     "lib/belly/cli.rb",
     "lib/belly/cli/init.rb",
     "lib/belly/client.rb",
     "lib/belly/client/config.rb",
     "lib/belly/for/cucumber.rb",
     "lib/belly/project_initializer.rb",
     "lib/belly/user_credentials.rb",
     "spec/belly/project_initializer_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/mattwynne/belly-mouth}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Client app for the incredible new belly web service, coming soon.}
  s.test_files = [
    "spec/belly/project_initializer_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
  end
end

