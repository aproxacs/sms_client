require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "sms_client"
    gem.summary = %Q{Free SMS libraray in Korea}
    gem.email = "aproxacs@gmail.com"
    gem.homepage = "http://github.com/aproxacs/sms_client"
    gem.authors = ["aproxacs"]
    gem.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "bin/send_text",
      "lib/sms_client.rb", "lib/sms_client/base.rb", "lib/sms_client/client/joyzen_client.rb",
      "lib/sms_client/client/lgt_client.rb", "lib/sms_client/client/paran_client.rb",
      "lib/sms_client/client/xpeed_client.rb",
      "lib/sms_client/client_methods.rb",
      "lib/sms_client/client_pool.rb"]
    gem.add_dependency("activesupport", [">= 2.0.2"])
    gem.add_dependency("mechanize", [">= 0.9.0"])
    gem.executables = ["send_text"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end


task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "sms_client #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

