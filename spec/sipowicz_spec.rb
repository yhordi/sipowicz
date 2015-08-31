describe Sipowicz do
  let(:new_user) {User.create(name: 'Topher', password: 'supermanz')}
  let(:params) { {user: {password: 'Canadian Travis'}, confirmation: 'Canadian Travis', old_password: 'supermanz'} }
  let(:good_config) {
    Sipowicz.configure(
      {password: params[:user][:password], 
        confirmation: params[:confirmation],
        old_password: params[:old_password]
      })
  }

  describe '#configure' do
    context 'on good params' do
      it 'assigns sipowicz class variables' do
        expect(good_config).to eq('Canadian Travis')
      end
    end
    context 'on bad params' do
      it 'raises an error with nil params' do
        expect{Sipowicz.configure({password: nil, confirmation: nil})}.to raise_error(RuntimeError)
      end
      it 'raises an error when an empty string is passed' do
        expect{Sipowicz.configure({password: '', confirmation: ''})}.to raise_error(RuntimeError)
      end
    end
  end
  describe '#options_error' do
    it 'raises a nil option error with nil params' do
      expect{Sipowicz.configure({password: nil})}.to raise_error(RuntimeError, 'Option passed to password is nil.')
    end
    it 'raises an empty string error when an empty string is passed' do
      expect{Sipowicz.configure({password: 'hello', confirmation: 'alskdfj', old_password: ''})}.to raise_error(RuntimeError, 'Option passed to old_password is an empty string.')
    end
  end

  describe '#update_user' do
    describe 'with valid params' do
      before(:each) do
        good_config
      end
      it 'calls #validate_new_passwords' do
        expect(Sipowicz.update_user(new_user)).to eq('Password updated')
      end
    end
    describe 'with invalid params' do
      before(:each) do
        Sipowicz.configure({password: params[:user][:password], confirmation: params[:confirmation], old_password: 'wrongo'})
      end
      it 'responds with an error message' do
        expect(Sipowicz.update_user(new_user)).to eq("Your new password was not saved. You entered your original password incorrectly.")
      end
    end
  end
end