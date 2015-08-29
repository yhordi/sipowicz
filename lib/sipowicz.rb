require 'active_model'
require 'active_support'
require_relative 'errors'
class Sipowicz
  include ActiveModel::SecurePassword
  include Errors
  @@messages = {notice: nil, error: nil}
  @@options_error = 'Options invalid. You must pass non empty strings for password and password confirmation'
  
  def self.configure(options)
    if options_valid?(options)
      @@password = options[:password]
      @@confirmation = options[:confirmation]
    end
  end

  def self.options_valid?(options)
    raise @@options_error if options[:password] == nil || options[:confirmation] == nil
    raise @@options_error if options[:password] == '' || options[:confirmation] == ''
    true
  end

  def self.valid_credentials?(user)
    user.authenticate(@@password) == user
  end

  def self.validate_user(user)
    if valid_credentials?(user)
      validate_new_passwords(user)
    else
      @@messages[:error] = Errors.unsaved_password(Errors.invalid_password)
    end
  end

  def self.new_passwords_match?
    @@password == @@confirmation
  end

  def self.fields_empty?
    @@passwored.blank? && params["password"].blank? && @@confirmation.blank?
  end

  def self.validation_redirect(user)
    if validate_user(user)
      redirect_to user_path(user.id)
    else
      redirect_to edit_user_path(user.id)
    end
  end

  def self.validate_new_passwords(user)
    if new_passwords_match?
      user.password = @@password
      user.update_attributes(password: @@password)
      @@messages[:notice] = "Password updated"
    else
      #needs refactoring
      @@messages[:error] = Errors.unsaved_password(Errors.non_matching)
    end
  end
end