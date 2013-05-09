$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "discussion/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name        = "discussion"
  gem.version     = Discussion::VERSION
  gem.authors     = ["A.K.M. Ashrafuzzaman"]
  gem.email       = ["ashrafuzzaman.g2@gmail.com"]
  gem.homepage    = "https://github.com/ashrafuzzaman/discussion"
  gem.summary     = "A gem to manage a thread discussion with ajax support."
  gem.description = ""

  gem.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  gem.test_files = Dir["test/**/*"]

  gem.add_dependency "rails", "~> 3.2.13"
  gem.add_dependency 'jquery-rails'
  gem.add_dependency 'simple_form'
  gem.add_dependency 'inherited_resources'
  gem.add_dependency 'kaminari'
  gem.add_dependency 'ransack'
  # s.add_dependency "jquery-rails"

  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "bullet"
  gem.add_development_dependency "rack-mini-profiler"
end