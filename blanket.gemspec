Gem::Specification.new do |s|
  s.name = %q{blanket}
  s.version = "0.0.1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jim Van Fleet"]
  s.date = %q{2008-03-02}
  s.email = %q{jim@jimvanfleet.com}
  s.executables = ["blanket", "blanket-cfg"]
  s.files = ["bin/blanket", "bin/blanket-cfg", "lib/blanket/config", "lib/blanket/config/reader.rb", "lib/blanket/config/writer.rb",  "lib/blanket/init.rb", "lib/blanket/sink.rb", "lib/blanket/source.rb", "lib/blanket/utils.rb", "lib/capistrano/recipes", "lib/capistrano/recipes/blanket.rb", "lib/blanket/plugins/sources", "lib/blanket/plugins/sources/confluence.rb", "lib/blanket/plugins/sources/mysql.rb", "lib/blanket/plugins/sources/subversion.rb", "lib/blanket/plugins/sinks/s3.rb", "spec/fixtures", "spec/confluence_spec.rb", "spec/dependency_spec.rb", "spec/fixtures/confluence.yml", "spec/fixtures/s3-info.yml",  "spec/reader_spec.rb", "spec/s3_spec.rb", "spec/spec_helper.rb", "spec/writer_spec.rb", "README", "MIT-LICENSE"]
  s.has_rdoc = false
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.0.1}
  s.summary = %q{Blanket is a flexible backup framework designed to get the drudgery out of the way and to make automated backups easy.}
  s.homepage = %q{http://www.jimvanfleet.com/projects/blanket}

  s.add_dependency(%q<capistrano>, [">= 2.0.0", "< 2.99.0"])
  s.add_dependency(%q<aws-s3>, [">= 0.4.0", "< 1.0"])
end