class CopDetective
  module ErrorMessages
    class << self
      def unsaved_password(reason)
        "Your new password was not saved. #{reason}"
      end

      def invalid_password
        "You entered your original password incorrectly."
      end

      def wrong_datatype
        'You must pass a hash to the set_keys method'
      end

      def formatting
        <<-MESSAGE 
        The keys in the hash you pass to #set_keys must be as follows:
          password:
          confirmation:
          old_password:
          
        the values you pass should reflect keys in your params hash.
        a correctly configured hash would look similar to this:
          password: :new_password
          confirmation: :password_again
          old_password: :original_password
        MESSAGE
      end

      def non_matching
        "Your new passwords don't match."
      end

      def show_errors(model)
        flash[:error] = model.errors.full_messages
      end

      def options_error(key, error)
        raise "Option passed to #{key} #{error}"
      end
    end
  end
end