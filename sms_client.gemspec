# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sms_client}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["aproxacs"]
  s.date = %q{2009-06-17}
  s.default_executable = %q{send_text}
  s.email = %q{aproxacs@gmail.com}
  s.executables = ["send_text"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/send_text",
     "lib/sms_client.rb",
     "lib/sms_client/base.rb",
     "lib/sms_client/client/joyzen_client.rb",
     "lib/sms_client/client/lgt_client.rb",
     "lib/sms_client/client/paran_client.rb",
     "lib/sms_client/client/xpeed_client.rb",
     "lib/sms_client/client_methods.rb",
     "lib/sms_client/client_pool.rb"
  ]
  s.homepage = %q{http://github.com/aproxacs/sms_client}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Free SMS libraray in Korea}
  s.test_files = [
    "spec/sms_client_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.0.2"])
      s.add_runtime_dependency(%q<mechanize>, [">= 0.9.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.0.2"])
      s.add_dependency(%q<mechanize>, [">= 0.9.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.0.2"])
    s.add_dependency(%q<mechanize>, [">= 0.9.0"])
  end
end
