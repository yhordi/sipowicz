require 'active_model'
require 'active_support'
require 'active_record'
require_relative 'errors'
require_relative 'validator'

class CopDetective
  cattr_reader :messages
  
    include ActiveModel::SecurePassword
    @@messages = CopDetectiveValidator.messages
    @@keychain = []
    @@params = Hash.new(nil)
    class << self

    def set_keys(keys)
      @@keys = keys
      set_keychain(@@keys)
    end

    def investigate(user, params)
      build_params(params)
      return create_user(user) if @@old_password == nil
      update_user(user)
    end

    private

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

    def build_params(params)
      params.each do |k, v|
        if v.is_a?(Hash)
          build_params(v)
        end
        @@params[k] = v if @@keychain.include?(k) 
      end
      p "Params built: " 
      p @@params
      translate_keys
    end

    def translate_keys
      @@internal_keys = @@keys
      @@internal_keys.each do |k, v|
        @@internal_keys[k] = @@params[v]
      end
      configure
    end

    def set_keychain
      @@keys.each do |k, v|
      @@keychain << v
      end
    end

    def configure
      @@old_password = @@internal_keys[:old_password]
      @@password = @@internal_keys[:password] || nil
      @@confirmation = @@internal_keys[:confirmation]
    end

    def validate_new_passwords(user)
      CopDetectiveValidator.validate_new_passwords(user, @@password, @@confirmation)
    end

    def valid_credentials?(user, old_password)
      CopDetectiveValidator.valid_credentials?(user, old_password)
    end

  end

end