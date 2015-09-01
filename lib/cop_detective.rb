require 'active_model'
require 'active_support'
require_relative 'errors'
require_relative 'validator'

class CopDetective
  cattr_reader :messages
  class << self
    
    include ActiveModel::SecurePassword
    # include Errors
    @@messages = CopDetectiveValidator.messages

    def configure(options)
      if CopDetectiveValidator.options_valid?(options)
        @@old_password = options[:old_password]
        @@password = options[:password]
        @@confirmation = options[:confirmation]
      end
    end

    def update_user(user)
      return validate_new_passwords(user) if valid_credentials?(user, @@old_password)
      messages[:error] = ErrorMessages.unsaved_password(ErrorMessages.invalid_password)
    end

    private

    def validate_new_passwords(user)
      CopDetectiveValidator.validate_new_passwords(user, @@password, @@confirmation)
    end

    def valid_credentials?(user, old_password)
      CopDetectiveValidator.valid_credentials?(user, old_password)
    end

  end

end