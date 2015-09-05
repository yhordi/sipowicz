describe CopDetective do
  let(:user) { User.create(name: 'Topher', password: 'supermanz') }
  let(:new_user) { User.new(name: 'Derek', password: 'Noodle') }
  let(:params) { {user: {password: 'Canadian Travis'}, confirmation: 'Canadian Travis', old_password: 'supermanz'} }
  let(:good_config) {
    CopDetective.configure(
      {password: params[:user][:password], 
        confirmation: params[:confirmation],
        old_password: params[:old_password]
      })
  }

  describe '#configure' do
    context 'on good params' do
      it 'assigns CopDetective class variables' do
        expect(good_config).to eq('Canadian Travis')
      end
    end
    context 'on bad params' do
      it 'raises an error with nil params' do
        expect{CopDetective.configure({password: nil, confirmation: nil})}.to raise_error(RuntimeError)
      end
      it 'raises an error when an empty string is passed' do
        expect{CopDetective.configure({password: '', confirmation: ''})}.to raise_error(RuntimeError)
      end
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
        expect(CopDetective.create_user(new_user)).to eq("Passwords don't match or other params are not valid.")
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