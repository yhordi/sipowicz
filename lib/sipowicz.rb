require 'active_model'
require 'active_support'
require_relative 'errors'

class Sipowicz
  cattr_reader :messages
  class << self
    include ActiveModel::SecurePassword
    include Errors
    @@options_errors = {option_nil: "is nil.",
                        empty: "is an empty string."
                        }
    @@messages = {notice: nil, error: nil}

    def configure(options)
      if options_valid?(options)
        @@old_password = options[:old_password]
        @@password = options[:password]
        @@confirmation = options[:confirmation]
      end
    end

    def update_user(user)
      return validate_new_passwords(user) if valid_credentials?(user)
      messages[:error] = Errors.unsaved_password(Errors.invalid_password)
    end
    
    def validate_new_passwords(user)
      if new_passwords_match?
        user.password = @@password
        user.update_attributes(password: @@password)
        @@messages[:notice] = "Password updated"
      else
        @@messages[:error] = Errors.unsaved_password(Errors.non_matching)
      end
    end

    def options_error(key, error)
      raise "Option passed to #{key} #{error}"
    end

    def options_valid?(options)
      options.each do |k, v|
        return options_error(k, @@options_errors[:option_nil]) if v.nil?
        return options_error(k, @@options_errors[:empty]) if v.empty?
      end
      true
    end

    def valid_credentials?(user)
      user.authenticate(@@old_password) == user
    end

    def new_passwords_match?
      @@password == @@confirmation
    end

  end
end