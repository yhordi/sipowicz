require 'active_support'
class CopDetectiveValidator
  include CopDetective::ErrorMessages
  cattr_accessor :messages
  class << self
    @@messages = {notice: nil, error: nil}
    @@options_errors = {option_nil: "is nil.",
                        empty: "is an empty string."
                        }
    def validate_new_passwords(user, password, confirmation)
      if new_passwords_match?(password, confirmation)
        user.password = password
        user.update_attributes(password: password)
        @@messages[:notice] = "Password updated"
      else
        @@messages[:error] = CopDetective::ErrorMessages.unsaved_password(CopDetective::ErrorMessages.non_matching)
      end
    end

    def options_valid?(options)
      options.each do |k, v|
        return CopDetective::ErrorMessages.options_error(k, @@options_errors[:option_nil]) if v.nil?
        return CopDetective::ErrorMessages.options_error(k, @@options_errors[:empty]) if v.empty?
      end
      true
    end

    def valid_credentials?(user, old_password)
      user.authenticate(old_password) == user
    end

    def new_passwords_match?(password, confirmation)
      password == confirmation
    end
  end
end