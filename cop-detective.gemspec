Gem::Specification.new 'cop-detective', '0.0.5' do |s|
  s.name        = 'cop-detective'
  s.version     = '0.0.5'
  s.date        = '2015-09-05'
  s.summary     = "Do your passwords match?"
  s.description = "A simple gem to use in your controller to remove some of the work of comparing passwords and confirmations."
  s.required_ruby_version = '>= 2.0.0'
  s.authors     = ["Jordan Kamin"]
  s.email       = 'jordanakamin@gmail.com'
  s.files       = ["lib/cop_detective.rb", "lib/validator.rb", "lib/errors.rb"]
  s.homepage    =
    'http://rubygems.org/gems/cop-detective'
  s.license       = 'MIT'
  s.add_runtime_dependency 'activerecord', '~> 4.0'
  s.add_runtime_dependency 'activemodel', '~> 4.0'
  s.add_runtime_dependency 'bcrypt', '~> 3.1'
end