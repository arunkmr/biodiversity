# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{biodiversity}
  s.version = "0.5.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dmitry Mozzherin"]
  s.date = %q{2009-08-12}
  s.default_executable = %q{nnparse}
  s.description = %q{TODO: longer description of your gem}
  s.email = %q{dmozzherin@gmail.com}
  s.has_rdoc = false
  s.executables = ["nnparse"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/nnparse",
     "biodiversity.gemspec",
     "conf/environment.rb",
     "lib/biodiversity.rb",
     "lib/biodiversity/guid.rb",
     "lib/biodiversity/guid/lsid.rb",
     "lib/biodiversity/parser.rb",
     "lib/biodiversity/parser/scientific_name_canonical.rb",
     "lib/biodiversity/parser/scientific_name_canonical.treetop",
     "lib/biodiversity/parser/scientific_name_clean.rb",
     "lib/biodiversity/parser/scientific_name_clean.treetop",
     "lib/biodiversity/parser/scientific_name_dirty.rb",
     "lib/biodiversity/parser/scientific_name_dirty.treetop",
     "pkg/.gitignore",
     "spec/biodiversity_spec.rb",
     "spec/guid/lsid.spec.rb",
     "spec/parser/scientific_name.spec.rb",
     "spec/parser/scientific_name_canonical.spec.rb",
     "spec/parser/scientific_name_clean.spec.rb",
     "spec/parser/scientific_name_dirty.spec.rb",
     "spec/parser/spec_helper.rb",
     "spec/parser/test_data.txt",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/dimus/biodiversity}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{TODO: one-line summary of your gem}
  s.test_files = [
    "spec/biodiversity_spec.rb",
     "spec/guid/lsid.spec.rb",
     "spec/parser/scientific_name.spec.rb",
     "spec/parser/scientific_name_canonical.spec.rb",
     "spec/parser/scientific_name_clean.spec.rb",
     "spec/parser/scientific_name_dirty.spec.rb",
     "spec/parser/spec_helper.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<treetop>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<treetop>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<treetop>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
