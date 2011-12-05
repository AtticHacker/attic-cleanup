# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name = 'attic-cleanup'
  spec.version ='0.0.5'
  spec.platform    = Gem::Platform::RUBY

  spec.files = ["README.md", "bin/attic-cleanup", "lib/attic-cleanup.rb",
    "lib/attic-cleanup/utility.rb", "lib/attic-cleanup/initialize/init.rb",
    "lib/attic-cleanup/log/log.rb", "lib/attic-cleanup/path/custom.rb",
    "lib/attic-cleanup/storage/folder_files.rb", "lib/attic-cleanup/storage/store_files.rb"]
  spec.require_paths = ["lib", "bin"]
  spec.executables   = ['attic-cleanup']
  spec.summary = "attic-cleanup is a gem to easily store your files when you need to get them out of the way."
  spec.author = 'Kevin van Rooijen'
  spec.email = 'kevin.van.rooijen@gmail.com'
  spec.homepage = 'http://rubygems.org/gems/attic-cleanup'

  spec.add_dependency 'thor'
end
