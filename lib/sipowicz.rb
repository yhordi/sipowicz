require 'active_model'
require 'active_support'
require_relative 'errors'
require_relative 'sipowicz_internal'

class Sipowicz
  cattr_reader :messages
  class << self
    include ActiveModel::SecurePassword
    include Errors

    @@messages = SipowiczInternal.messages

    def configure(options)
      if SipowiczInternal.options_valid?(options)
        @@old_password = options[:old_password]
        @@password = options[:password]
        @@confirmation = options[:confirmation]
      end
    end

    def update_user(user)
      return validate_new_passwords(user) if valid_credentials?(user)
      messages[:error] = Errors.unsaved_password(Errors.invalid_password)
    end

    private

    def validate_new_passwords(user, password, confirmation)
      SipowiczInternal.validate_new_passwords(user, password, confirmation)
    end

    def valid_credentials?(user, password)
      SipowiczInternal.valid_credentials?(user, password)
    end

  end
end