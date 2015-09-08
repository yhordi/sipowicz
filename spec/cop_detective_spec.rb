describe CopDetective do
  let(:user) { User.create(name: 'Topher', password: 'supermanz') }
  let(:new_user) { User.new(name: 'Derek', password: 'Noodle') }
  let(:params) { {user: {password: 'Canadian Travis'}, confirmation: 'Canadian Travis', old_password: 'supermanz'} }
  let(:good_config) {
      {password: params[:user][:password], 
        confirmation: params[:confirmation],
        old_password: params[:old_password]
      }
  }

  describe '#set_keys' do
    it 'throws an error when passed something other than a hash' do
      expect{CopDetective.set_keys(1)}.to raise_error(RuntimeError, 'You must pass a hash to the set_keys method')
    end
    it "throws an error when the hash's keys are set incorrectly" do
    end
  end

  describe '#options_error' do
    it 'raises a nil option error with nil params' do
      expect{CopDetective.configure({password: nil})}.to raise_error(RuntimeError, 'Option passed to password is nil.')
    end
    it 'raises an empty string error when an empty string is passed' do
      expect{CopDetective.configure({password: 'hello', confirmation: 'alskdfj', old_password: ''})}.to raise_error(RuntimeError, 'Option passed to old_password is an empty string.')
    end
  end

  describe '#update_user' do
    describe 'with valid params' do
      before(:each) do
        good_config
      end
      it 'calls #validate_new_passwords' do
        expect(CopDetective.update_user(user)).to eq('Password updated')
      end
    end
    describe 'with invalid params' do
      before(:each) do
        CopDetective.configure({password: params[:user][:password], confirmation: params[:confirmation], old_password: 'wrongo'})
      end
      it 'responds with an error message' do
        expect(CopDetective.update_user(user)).to eq("Your new password was not saved. You entered your original password incorrectly.")
      end
    end
  end

  describe '#create_user' do
    describe 'with valid params' do
      before(:each) do
        CopDetective.configure({password: params[:user][:password], confirmation: params[:confirmation]})
      end
      it 'responds with a success message' do
        expect(CopDetective.create_user(new_user)).to eq("Account created. You may now log in.")
      end
      it 'creates a new user in the database' do
        CopDetective.create_user(new_user)
        expect(User.last).to eq(new_user)
      end
    end
    describe 'with invalid params' do
      it 'responds with an error message' do
        CopDetective.configure({password: params[:user][:password], confirmation: 'speerp'})
        expect(CopDetective.create_user(new_user)).to include("Passwords don't match or other params are not valid.")
      end
    end
  end

  describe '#create_user' do
    describe 'with valid params' do
      it 'responds with a success message' do
        good_config
        expect(CopDetective.create_user(user)).to eq("Account created. You may now log in.")
      end
    end
    describe 'with invalid params' do
    end
  end
end