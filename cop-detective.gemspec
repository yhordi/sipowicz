Gem::Specification.new do |s|
  s.name        = 'CopDetective-rails'
  s.version     = '0.0.1'
  s.date        = '2015-08-08'
  s.summary     = "Do your passwords match?"
  s.description = "A simple gem to use in your controller to check if your passwords match before you save or update user data."
  s.authors     = ["Jordan Kamin"]
  s.email       = 'jordanakamin@gmail.com'
  s.files       = ["lib/CopDetective.rb"]
  s.homepage    =
    'http://rubygems.org/gems/CopDetective'
  s.license       = 'MIT'
  s.add_runtime_dependency 'activerecord'
  s.add_runtime_dependency 'activemodel'
  s.add_runtime_dependency 'bcrypt'
end