require 'active_support'
require 'active_record'

class CopDetectiveValidator
  include CopDetective::ErrorMessages
  cattr_accessor :messages
  
  class << self
    @@messages = {notice: nil}
    @@options_errors = {option_nil: "is nil.",
                        empty: "is an empty string."
                        }
    def validate_new_passwords(user, password, confirmation)
      if new_passwords_match?(password, confirmation)
        user.password = password
        @@messages[:notice] = "Password updated"
      else
        user.errors.full_messages << CopDetective::ErrorMessages.unsaved_password(CopDetective::ErrorMessages.non_matching)
      end
    end

    def valid_credentials?(user, old_password)
      user.authenticate(old_password) == user
    end

    def new_passwords_match?(password, confirmation)
      password == confirmation
    end
  end
end