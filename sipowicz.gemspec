Gem::Specification.new do |s|
  s.name        = 'sipowicz-rails'
  s.version     = '0.0.1'
  s.date        = '2015-08-08'
  s.summary     = "Do your passwords match?"
  s.description = "A simple gem to use in your controller to check if your passwords match before you save or update user data."
  s.authors     = ["Jordan Kamin"]
  s.email       = 'jordanakamin@gmail.com'
  s.files       = ["lib/sipowicz.rb"]
  s.homepage    =
    'http://rubygems.org/gems/sipowicz'
  s.license       = 'MIT'
  s.add_runtime_dependency 'activerecord'

end