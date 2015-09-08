require 'active_model'
require 'active_support'
require 'active_record'
require_relative 'errors'
require_relative 'validator'
require_relative 'assigner'

class CopDetective
  cattr_reader :messages
    include ActiveModel::SecurePassword
    @@messages = CopDetectiveValidator.messages

    class << self

    def configure(options)
      @@old_password = options[:old_password]
      @@password = options[:password]
      @@confirmation = options[:confirmation]
    end

    def set_keys(keys)
      raise CopDetective::ErrorMessages.wrong_datatype if keys.class != Hash
      inspect_keys(keys)
      @@keys = keys
      set_keychain(@@keys)
    end

    def investigate(user, params)
      assign(params)
      return create_user(user) if @@old_password == nil
      update_user(user)
    end

    private

    def inspect_keys(keys)
      keys.each do |k, v|
        raise CopDetective::ErrorMessages.formatting if k != :confirmation && k != :password && k != :old_password
      end
    end

    def update_user(user)
      return validate_new_passwords(user) if valid_credentials?(user, @@old_password)
      messages[:error] = ErrorMessages.unsaved_password(ErrorMessages.invalid_password)
    end

    def create_user(user)
      if CopDetectiveValidator.new_passwords_match?(@@password, @@confirmation) && user.valid?
        user.save
        @@messages[:notice] = "Account created. You may now log in."
      else
        user.errors.full_messages << "Passwords don't match or other params are not valid."
      end
    end

    def assign(params)
      CopDetectiveAssigner.assign(params)
    end

    def set_keychain(keys)
      CopDetectiveAssigner.set_keychain(keys)
    end

    def validate_new_passwords(user)
      CopDetectiveValidator.validate_new_passwords(user, @@password, @@confirmation)
    end

    def valid_credentials?(user, old_password)
      CopDetectiveValidator.valid_credentials?(user, old_password)
    end

  end

end