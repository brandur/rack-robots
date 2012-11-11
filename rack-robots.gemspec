Gem::Specification.new do |gem|
  gem.name        = "rack-robots"
  gem.version     = "0.1.2"

  gem.author      = "Brandur"
  gem.email       = "brandur@mutelight.org"
  gem.homepage    = "https://github.com/brandur/rack-robots"
  gem.license     = "MIT"
  gem.summary     = "Rack middleware that denies all robots for staging and development environments."

  gem.files = %w{README.md lib/rack/robots.rb}
end
