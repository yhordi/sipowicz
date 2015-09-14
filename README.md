# cop-detective
[![Gem Version](https://badge.fury.io/rb/cop-detective.svg)](http://badge.fury.io/rb/cop-detective)
![Travis CI](https://travis-ci.org/yhordi/cop-detective.svg?branch=master)

## A gem designed to remove some of the heavy lifting of comparing passwords and password confirmations in your rails 4 controller.

### Setup
---

In your Gemfile:

    gem 'cop-detective'

Then from your command line run:
  
    $ bundle install

In config/application.rb:

    require 'cop_detective'

<p> To get started with cop-detective you'll need to tell it what keys in your params sent from the client will be relevant to updating or creating a user's password. Take this params hash for example</p>

    {:user => {"password" => "hello", "id" => 47'}, :password_again => "hello",  :original_password => "dropTop"}

in this case the relevant keys in the hash are "password", :password_again, and :original_password. In order for cop-detective to be able to check params passed to it you'll need to call the #set_keys  method below and pass it a hash where the keys are :password, :confirmation, and :old_password, and the values are the relevant keys in your params hash. You call the #set_keys method just below where you required the gem.

    require 'cop_detective'  
    CopDetective.set_keys({:password => "password", :confirmation => :password_again, :old_password => :original_password})

### Usage
---
Once you've configured the gem you'll simply call the #investigate method in your controller.  
app/controllers/users_controller.rb:

    def create
      user = User.new(name: params["user"]["name"], password: params["user"]["password"])
      CopDetective.investigate(user, params)
      redirect_to root_path
    end

Calling CopDetective.investigate here will save your new user.

this is what it should look like in that same controller's update method:

    def update
      user = User.find(params[:id]
      CopDetective.investigate(user, params)
      user.update_attributes(user_params)
    end

Calling CopDetective.investigate here will check your relevant field, but will not update your user. This example assumes you are using strong params defined elsewhere in your controller.

### Bugs
If you have any questions or find any bugs pleas file use GitHub issues.

### Changelog
---

#### V 0.1.4
- CopDetective#investigate no longer updates password in the database, but it does still update the attribute on the passed user object

#### V 0.1.3
- Users can now pass strings as well as symbols to CopDetective#set_keys

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
