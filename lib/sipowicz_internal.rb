require 'active_support'
class SipowiczInternal
  cattr_accessor :messages
  class << self
    @@messages = {notice: nil, error: nil}
    @@options_errors = {option_nil: "is nil.",
                        empty: "is an empty string."
                        }
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