Gem::Specification.new 'cop-detective', '0.1.0' do |s|
  s.name        = 'cop-detective'
  s.version     = '0.1.0'
  s.date        = '2015-09-02'
  s.summary     = "Do your passwords match?"
  s.description = "A simple gem to use in your controller to check if your passwords match before you save or update user data."
  s.authors     = ["Jordan Kamin"]
  s.email       = 'jordanakamin@gmail.com'
  s.files       = ["lib/cop_detective.rb", "lib/validator.rb", "lib/errors.rb"]
  s.homepage    =
    'http://rubygems.org/gems/cop-detective'
  s.license       = 'MIT'
  s.add_runtime_dependency 'activerecord'
  s.add_runtime_dependency 'activemodel'
  s.add_runtime_dependency 'bcrypt'
end