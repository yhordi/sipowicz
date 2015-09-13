# Cop-Detective
[![Gem Version](https://badge.fury.io/rb/cop-detective.svg)](http://badge.fury.io/rb/cop-detective)
[![Travis CI](https://travis-ci.org/yhordi/cop-detective.svg?branch=master)]
#### an open-source password validator for use with rails 4.

<p> Note: This is the pre-alpha version of this gem, so it is probably riddled with bugs.</p>

###Changelog

#### V 0.1.2
- Fixes a bug that was causing incorrect errors being thrown when creating a new user

#### V 0.1.1
- Fixes a bug in the gemspec that was causing assigner.rb to not get pushed

#### V 0.1.0
- Creates a CopDetectiveAssigner class which makes configuration easier on the user
- Removes the work of having to call separate methods when updating or creating respectively, now a user can just pass params and a user object to the investigate method.

#### V 0.0.5
- Migrates error handling of user validation to ActiveRecord objects. Errors can now be accessed through user.errors.full_messages.

#### V 0.0.3
- Adds #create_user method
