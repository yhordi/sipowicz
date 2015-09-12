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
      inspect_values(keys)
      @@keys = keys
    end

    def investigate(user, params)
      reset_variables
      assign(params, @@keys)
      return create_user(user) if @@old_password == nil
      update_user(user)
    end

    private

    def reset_variables
      @@old_password = nil
      @@password = nil
      @@confirmation = nil
    end

    def inspect_keys(keys)
      keys.each do |k, v|
        raise CopDetective::ErrorMessages.formatting if k != :confirmation && k != :password && k != :old_password
      end
    end

    def inspect_values(keys)
      keys.each do |k, v|
        raise CopDetective::ErrorMessages.options_error(k) if v.class != Symbol
      end
    end

    def update_user(user)
      return validate_new_passwords(user) if valid_credentials?(user, @@old_password)
      user.errors.set(:password, [ErrorMessages.unsaved_password(ErrorMessages.invalid_password)])
    end

    def create_user(user)
      if CopDetectiveValidator.new_passwords_match?(@@password, @@confirmation) && user.valid?
        user.save
        @@messages[:notice] = "Account created. You may now log in."
      else
        user.errors.set(:password, ["Passwords don't match or other params are not valid."])
      end
    end

    def assign(params, keys)
      CopDetectiveAssigner.assign(params, keys)
    end

    def validate_new_passwords(user)
      CopDetectiveValidator.validate_new_passwords(user, @@password, @@confirmation)
    end

    def valid_credentials?(user, old_password)
      CopDetectiveValidator.valid_credentials?(user, old_password)
    end

  end

end