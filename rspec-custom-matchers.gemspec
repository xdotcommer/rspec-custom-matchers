# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec-custom-matchers}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["xdotcommer", "remi"]
  s.date = %q{2009-01-28}
  s.description = %q{Define RSpec custom matchers in 1 line}
  s.email = %q{remi@remitaylor.com}
  s.files = ["VERSION.yml", "README.markdown", "lib/rspec-custom-matchers.rb", "spec/custom_matcher_spec.rb", "spec/matcher_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/remi/rspec-custom-matchers}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Define RSpec custom matchers in 1 line}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
